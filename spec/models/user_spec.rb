require 'rails_helper'

describe User, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_presence_of(:salt) }
    it { is_expected.to validate_presence_of(:admin) }
  end

  describe 'methods' do
    it 'should return true/false for if a user is an admin' do
      user = User.new(name: 'Bob', email: 'bob@bob.com', password: 'a', salt: 'b', admin: true)
      user2 = User.new(name: 'Bob', email: 'bob@bob.com', password: 'a', salt: 'b', admin: false)

      expect(user.admin?).to be(true)
      expect(user2.admin?).to be(false)
    end
  end
end
