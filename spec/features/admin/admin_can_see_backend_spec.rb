require 'rails_helper'

describe 'Authorization' do
  describe 'an admin' do
    scenario 'can access the admin backend' do
      user = User.create!(
        name: 'Bob Ross',
        email: 'bob@bobross.com',
        password: 'happy_little_trees',
        role: 1
      )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit admin_currencies_path
      expect(page).to have_content('Currencies')
    end
  end

  describe 'a regular user' do
    scenario 'cannot access admin backend' do
      user = User.create!(
        name: 'Bob Ross',
        email: 'bob@bobross.com',
        password: 'happy_little_trees',
        role: 0
      )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit admin_currencies_path
      expect(page).to_not have_content('Travelistics Admin')
      expect(page).to have_content('The page you were looking for doesn\'t exist.')
    end
  end
end