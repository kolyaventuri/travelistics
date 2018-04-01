require 'rails_helper'

describe 'User visits /account' do
  user = {
    name: 'Bob Ross',
    email: 'bob@bobross.com',
    password: 'happy_little_trees'
  }

  before(:all) do
    User.create!(user)
    DatabaseCleaner.clean
  end

  after(:each) do
    Capybara.reset_sessions!
  end

  after(:all) do
    DatabaseCleaner.clean
  end

  describe 'when logged in' do
    it 'should show them their info' do
      visit login_path
      fill_in 'user[email]', with: user[:email]
      fill_in 'user[password]', with: user[:password]
      click_on 'Login'

      visit account_path

      expect(current_path).to eq(account_path)
      expect(page).to have_content("Welcome #{user[:name]}")
    end
  end

  describe 'when not logged in' do
    it 'should redirect them to the login page' do
      visit account_path
      expect(current_path).to eq(login_path)
    end
  end
end
