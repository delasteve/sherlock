# == Schema Information
#
# Table name: users
#
#  id            :integer         not null, primary key
#  username      :string(255)
#  password_hash :string(255)
#  password_salt :string(255)
#  what_uid      :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class User < ActiveRecord::Base
  attr_accessible :username, :password, :password_confirmation, :what_uid
  has_many :statistics

  attr_accessor :password
  before_save :encrypt_password

  validates :username, :uniqueness => true,
                       :presence => true
  validates :password, :confirmation => true,
                       :presence => true
  validates :what_uid, :uniqueness => true,
                       :presence => true


  def self.authenticate(username, password)
    user = find_by_username(username)
    (user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)) ? user : nil
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.password_salt == cookie_salt) ? user : nil
  end

  def get_initial_statistics
    json = get_user_profile
    statistic = self.statistics.create(:uploaded => json['response']['stats']['uploaded'].to_i,
                                       :downloaded => json['response']['stats']['downloaded'].to_i,
                                       :posts => json['response']['community']['posts'],
                                       :uploads => json['response']['community']['uploaded'].to_i,
                                       :seeding => json['response']['community']['seeding'].to_i,
                                       :leeching => json['response']['community']['leeching'].to_i,
                                       :snatched => json['response']['community']['snatched'].to_i,
                                       :ratio => (json['response']['stats']['uploaded'].to_f / json['response']['stats']['downloaded'].to_f),
                                       :buffer => (json['response']['stats']['uploaded'].to_i - json['response']['stats']['downloaded'].to_i))
    statistic.create_hourly_statistic(:change_in_uploaded => 0,
                                      :change_in_downloaded => 0,
                                      :change_in_uploads => 0,
                                      :change_in_snatched => 0,
                                      :change_in_posts => 0,
                                      :change_in_seeding => 0,
                                      :change_in_leeching => 0,
                                      :change_in_buffer => 0,
                                      :change_in_ratio => 0)
  end

  private
    def encrypt_password
      if password.present?
        self.password_salt = BCrypt::Engine.generate_salt
        self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
      end
    end

    def get_user_profile
      agent = Mechanize.new
      agent.user_agent_alias = "Windows Mozilla"

      page = agent.get("#{APP_CONFIG['base_url']}/login.php")
      login_form = page.forms.last
      login_form.username = APP_CONFIG['username']
      login_form.password = APP_CONFIG['password']
      page = agent.submit login_form

      url = "#{APP_CONFIG['base_url']}/ajax.php?action=user&id=#{what_uid}&auth=#{APP_CONFIG['auth_key']}"
      data = agent.get(url).body
      JSON.parse(data)
    end
end

