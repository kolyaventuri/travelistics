require 'rails_helper'

describe 'Authorization' do
  before(:all) do
    DatabaseCleaner.clean
    @user = User.create!(
      name: 'Bob Ross',
      email: 'bob@bobross.org',
      password: 'happy_little_trees'
    )
  end

  after(:all) do
    DatabaseCleaner.clean
  end

  describe 'a logged in user' do
    scenario 'can access their trips' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit trips_path
      expect(page).to have_content('Your Trips')
    end
  end

  describe 'a visitor' do
    scenario 'is redirected to the login page' do
      visit trips_path

      expect(page).to_not have_content('Your Trips')
      expect(current_path).to eq(login_path)
    end
  end
end
