require 'rails_helper'

describe 'User visiting /login' do
  before(:each) do
    DatabaseCleaner.clean
  end

  after(:each) do
    DatabaseCleaner.clean
  end

  user = {
    name: 'Bob Ross',
    email: 'bob@bobross.com',
    password: 'happy_little_trees'
  }

  describe 'should allow them to login successfully' do
    it 'should set a session cookie' do
      User.create!(user)
      visit login_path

      expect(page).to have_content('Login')

      fill_in 'user[email]', with: user[:email]
      fill_in 'user[password]', with: user[:password]

      within('.container') do
        click_on 'Login'
      end

      expect(current_path).to eq(account_path)
    end
  end

  describe 'it should deny invalid combinations' do
    it 'should display an error message if the password/username is incorrect' do
      visit login_path

      fill_in 'user[email]', with: 'invalid'
      fill_in 'user[password]', with: 'invalid'

      within('.container') do
        click_on 'Login'
      end

      expect(page).to have_content('Your email or password was incorrect.')

      visit account_path

      expect(current_path).to eq(login_path)
    end
  end
end
