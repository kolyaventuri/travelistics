require 'rails_helper'

describe 'Authorization' do
  describe 'an admin' do
    scenario 'can access the currencies list' do
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
    scenario 'cannot access currencies list' do
      user = User.create!(
        name: 'Bob Ross',
        email: 'bob@bobross.com',
        password: 'happy_little_trees',
        role: 0
      )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit admin_currencies_path
      expect(page).to_not have_content('Currencies')
      expect(page).to have_content('The page you were looking for doesn\'t exist.')
    end
  end
end

describe 'Admin' do
  before(:all) do
    DatabaseCleaner.clean

    codes = ['USD', 'GBP', 'RUB', 'MEX']
    @currencies = codes.map do |code|
      Currency.create!(code: code)
    end

    @user = User.create!(
      name: 'Bob Ross',
      email: 'bob@bobross.com',
      password: 'happy_little_trees',
      role: 1
    )
  end

  after(:all) do
    DatabaseCleaner.clean
  end

  scenario 'can see list of currencies' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit admin_currencies_path

    within('.currencies') do
      @currencies.each do |currency|
        expect(page).to have_content(currency.code)
      end
    end
  end
end