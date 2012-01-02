class User < ActiveRecord::Base
  attr_accessible :username, :password, :password_confirmation, :whatid

  attr_accessor :password
  before_save :encrypt_password

  validates :username, :uniqueness => true,
                       :presence => true
  validates :password, :confirmation => true,
                       :presence => true
  validates :whatid,   :uniqueness => true,
                       :presence => true

  def self.authenticate(username, password)
    user = find_by_username(username)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end

