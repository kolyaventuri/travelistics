require 'bcrypt'

# User
class User < ApplicationRecord
  enum role: [:default, :admin]
  
  validates_presence_of :name
  validates_presence_of :email
  validates_presence_of :password

  validates_uniqueness_of :email

  validates_confirmation_of :email
  validates_confirmation_of :password

  after_initialize :init

  def init
    generate_salt
  end

  def update_password(password)
    self.salt = nil
    self.password = password
    generate_salt
  end

  def self.authenticate(email, password)
    user = User.where(email: email).first
    return nil if user.nil?

    crypted_password = BCrypt::Engine.hash_secret(password, user.salt)

    user if crypted_password == user.password
  end

  private

  def generate_salt
    if salt.nil?
      self.salt ||= BCrypt::Engine.generate_salt
      self.password = BCrypt::Engine.hash_secret(password, self.salt)
      if password_confirmation
        self.password_confirmation = BCrypt::Engine.hash_secret(password_confirmation, self.salt)
      end
    end
  end
end
