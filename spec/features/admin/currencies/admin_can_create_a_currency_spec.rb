require 'rails_helper'

describe 'Authorization' do
  describe 'an admin' do
    scenario 'can access the currency creation page' do
      user = User.create!(
        name: 'Bob Ross',
        email: 'bob@bobross.com',
        password: 'happy_little_trees',
        role: 1
      )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit new_admin_currency_path
      expect(page).to have_content('Add a Currency')
    end
  end

  describe 'a regular user' do
    scenario 'cannot access the currency edit page' do
      user = User.create!(
        name: 'Bob Ross',
        email: 'bob@bobross.com',
        password: 'happy_little_trees',
        role: 0
      )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit new_admin_currency_path
      expect(page).to_not have_content('Add a Currency')
      expect(page).to have_content('The page you were looking for doesn\'t exist.')
    end
  end
end

describe 'Admin' do
  before(:all) do
    DatabaseCleaner.clean

    @currency = Currency.create!(code: 'USD')

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

  scenario 'can add a currency' do
    new_code = 'RUB'

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit admin_currencies_path

    within('.currencies') do
      expect(page).to have_content(@currency.code)
      expect(page).to_not have_content(new_code)
    end

    click_on 'Add a Currency'

    expect(current_path).to eq(new_admin_currency_path)

    fill_in 'currency[code]', with: new_code
    click_on 'Add Currency'

    expect(current_path).to eq(admin_currencies_path)
    expect(page).to have_content(new_code)
    expect(page).to have_content(@currency.code)
  end
end