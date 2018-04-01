require 'rails_helper'

describe 'User visiting /register' do
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

  describe 'allows them to create an account' do
    it 'should show them their account page' do
      visit registration_path

      expect(page).to have_content('Create an Account')

      fill_in 'user[name]', with: user[:name]
      fill_in 'user[email]', with: user[:email]
      fill_in 'user[email_confirmation]', with: user[:email]
      fill_in 'user[password]', with: user[:password]
      fill_in 'user[password_confirmation]', with: user[:password]

      click_on 'Create Account'

      expect(page).to have_content("Welcome #{user[:name]}!")
      expect(current_path).to eq(account_path)
    end
  end

  describe 'disallows duplicate emails' do
    it 'should throw an error' do
      User.create!(user)

      visit registration_path

      expect(page).to have_content('Create an Account')

      fill_in 'user[name]', with: user[:name]
      fill_in 'user[email]', with: user[:email]
      fill_in 'user[email_confirmation]', with: user[:email]
      fill_in 'user[password]', with: user[:password]
      fill_in 'user[password_confirmation]', with: user[:password]

      click_on 'Create Account'

      expect(page).to_not have_content("You have successfully registered, #{user[:name]}!")
      expect(page).to have_content('The provided email is already in use.')
      expect(current_path).to eq(registration_path)
    end
  end
end
