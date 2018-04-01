require 'rails_helper'

describe User, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }

    it { is_expected.to validate_uniqueness_of(:email) }

    it { is_expected.to validate_confirmation_of(:email) }
    it { is_expected.to validate_confirmation_of(:password) }

    it 'should not be an admin by default' do
      user = User.new(name: 'A', email: 'B', password: 'C', salt: 'D')
      expect(user).to be_valid
      expect(user.admin).to be(false)
    end

    it 'should be able to be an admin upon creation' do
      user = User.new(name: 'A', email: 'B', password: 'C', salt: 'D', admin: true)
      expect(user).to be_valid
      expect(user.admin).to be(true)
    end

    it 'should be assigned a password salt upon creation' do
      input_password = 'password'
      user = User.new(name: 'A', email: 'B', password: input_password)
      expect(user).to be_valid
      expect(user.salt).to_not be_nil
      expect(user.password).to_not eq(input_password)
    end

    it 'should preserve salt' do
      input_password = 'password'
      input_salt = 'salty'
      user = User.new(name: 'A', email: 'B', password: input_password, salt: input_salt)
      expect(user).to be_valid
      expect(user.salt).to eq(input_salt)
      expect(user.password).to eq(input_password)
    end
  end

  describe 'methods' do
    before(:each) do
      DatabaseCleaner.clean
    end

    after(:each) do
      DatabaseCleaner.clean
    end
    
    describe 'user#admin?' do
      it 'should return true/false for if a user is an admin' do
        user = User.new(name: 'Bob', email: 'bob@bob.com', password: 'a', salt: 'b', admin: true)
        user2 = User.new(name: 'Bob', email: 'bob@bob.com', password: 'a', salt: 'b', admin: false)

        expect(user.admin?).to be(true)
        expect(user2.admin?).to be(false)
      end
    end

    describe 'User#authenticate' do
      it 'should be able to authenticate a user' do
        user_info = {
          name: 'Bob Ross',
          email: 'bob@bobross.com',
          password: 'happy_little_trees'
        }

        user = User.create!(user_info)

        good = User.authenticate(user_info[:email], user_info[:password])

        expect(good).to eq(user)

        bad = User.authenticate(user_info[:email], 'wrong')

        expect(bad).to be_nil
      end
    end
  end
end
