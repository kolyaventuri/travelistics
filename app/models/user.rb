# User
class User < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :email
  validates_presence_of :password
  validates_presence_of :salt
  validates_inclusion_of :admin, in: [true, false]

  validates_uniqueness_of :email

  validates_confirmation_of :email
  validates_confirmation_of :password

  after_initialize :init

  def init
    self.admin ||= false
  end

  def admin?
    admin
  end
end
