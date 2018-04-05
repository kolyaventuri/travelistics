require 'rails_helper'

describe 'Authenticated user visiting /logout' do
  user = {
    name: 'Bob Ross',
    email: 'bob@bobross.com',
    password: 'happy_little_trees'
  }

  before(:all) do
    DatabaseCleaner.clean
    User.create!(user)
  end

  after(:all) do
    DatabaseCleaner.clean
  end

  describe 'should allow them to logout' do
    it 'should delete the session id' do
      visit login_path
      fill_in 'user[email]', with: user[:email]
      fill_in 'user[password]', with: user[:password]

      within('.container') do
        click_on 'Login'
      end

      visit logout_path

      expect(current_path).to eq(root_path)

      visit account_path

      expect(current_path).to eq(login_path)
    end
  end
end
