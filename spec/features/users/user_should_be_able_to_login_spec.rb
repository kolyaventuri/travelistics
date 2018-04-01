require 'rails_helper'

describe 'User visiting /login' do
  before(:all) do
    DatabaseCleaner.clean
  end

  after(:all) do
    DatabaseCleaner.clean
  end

  user = {
    name: 'Bob Ross',
    email: 'bob@bobross.com',
    password: 'happy_little_trees'
  }

  describe 'should allow them to login successfully' do
    User.create!(user)
    
    it 'should set a session cookie' do
      visit login_path

      expect(page).to have_content('Login')

      fill_in 'user[email]', with: user[:email]
      fill_in 'user[password]', with: user[:password]

      click_on 'Login'

      cookies = Capybara
                .current_session
                .driver
                .request
                .cookies

      expect(cookies.fetch('sid')).to_not be_nil
    end
  end
end
