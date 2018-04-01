# User
class User < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :email
  validates_presence_of :password
  validates_presence_of :salt
  validates_presence_of :admin

  validates_uniqueness_of :email

  validates_confirmation_of :email
  validates_confirmation_of :password

  def admin?
    admin
  end
end
