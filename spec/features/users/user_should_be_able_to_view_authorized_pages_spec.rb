require 'rails_helper'

describe 'User visits /account' do
  user_info = {
    name: 'Bob Ross',
    email: 'bob@bobross.com',
    password: 'happy_little_trees'
  }

  before(:all) do
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
      user = User.create!(user_info)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit account_path

      expect(current_path).to eq(account_path)
      expect(page).to have_content("Welcome #{user_info[:name]}!")
    end
  end

  describe 'when not logged in' do
    it 'should redirect them to the login page' do
      visit account_path
      expect(current_path).to eq(login_path)
    end
  end
end
