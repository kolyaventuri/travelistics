require 'rails_helper'

describe 'Authorization' do
  describe 'an admin' do
    scenario 'can access the country create page' do
      user = User.create!(
        name: 'Bob Ross',
        email: 'bob@bobross.com',
        password: 'happy_little_trees',
        role: 1
      )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit new_admin_country_path
      expect(page).to have_content('Add Country')
    end
  end

  describe 'a regular user' do
    scenario 'cannot access the country create page' do
      user = User.create!(
        name: 'Bob Ross',
        email: 'bob@bobross.com',
        password: 'happy_little_trees',
        role: 0
      )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit new_admin_country_path
      expect(page).to_not have_content('Add Country')
      expect(page).to have_content('The page you were looking for doesn\'t exist.')
    end
  end
end

describe 'Admin' do
  before(:all) do
    DatabaseCleaner.clean
    @currency = Currency.create!(code: 'USD')
    @currency2 = Currency.create!(code: 'GBP')
  end

  after(:all) do
    DatabaseCleaner.clean
  end
  scenario 'can create a new country' do
    country_data = {
      name: 'United States',
      code: 'US',
      currency: 'USD',
      side_of_road: 'right'
    }

    visit new_admin_country_path

    fill_in 'country[name]', with: country_data[:name]
    fill_in 'country[code]', with: country_data[:code]
    fill_in 'country[side_of_road]', with: country_data[:side_of_road]
    select country_data[:currency], from: 'country[currency]'

    click_on 'Create Country'

    expect(current_path).to eq(admin_country_path(Country.first))
    expect(page).to have_content(country_data[:name])
    expect(page).to have_content(country_data[:code])
    expect(page).to have_content(country_data[:side_of_road])
    expect(page).to have_content(country_data[:currency])
    expect(page).to_not have_content(country_data[:currency])
  end
end
