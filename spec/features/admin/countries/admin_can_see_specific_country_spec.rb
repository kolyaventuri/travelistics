require 'rails_helper'

describe 'Admin' do
  before(:all) do
    DatabaseCleaner.clean
  end

  after(:all) do
    DatabaseCleaner.clean
  end

  scenario 'can see a list of countries' do
    user = User.create!(
      name: 'Bob Ross',
      email: 'bob@bobross.com',
      password: 'happy_little_trees',
      role: 1
    )

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    currency = Currency.create!(code: 'USD')
    language = Language.create!(name: 'English', code: 'EN')

    country = Country.create!(name: 'United States', code: 'US', side_of_road: 'right', currency: currency)

    country.languages << language

    visit admin_country_path(country)

    expect(page).to have_content(country.name)
    expect(page).to have_content(country.code)
    expect(page).to have_content(country.side_of_road)

    expect(page).to have_content(country.currency.code)
    expect(page).to have_content(country.languages.first.name)
  end
end