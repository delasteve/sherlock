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

  private
    def encrypt_password
      if password.present?
        self.password_salt = BCrypt::Engine.generate_salt
        self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
      end
    end
end

