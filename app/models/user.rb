require 'bcrypt'

# User
class User < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :email
  validates_presence_of :password
  validates_inclusion_of :admin, in: [true, false]

  validates_uniqueness_of :email

  validates_confirmation_of :email
  validates_confirmation_of :password

  after_initialize :init

  def init
    self.admin ||= false
    generate_salt
  end

  def admin?
    admin
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
