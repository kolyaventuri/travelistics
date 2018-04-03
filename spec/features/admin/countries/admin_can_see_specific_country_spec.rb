require 'rails_helper'

describe 'Admin' do
  before(:all) do
    DatabaseCleaner.clean
  end

  after(:all) do
    DatabaseCleaner.clean
  end

  scenario 'can see a countries data' do
    user = User.create!(
      name: 'Bob Ross',
      email: 'bob@bobross.com',
      password: 'happy_little_trees',
      role: 1
    )

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    currency = Currency.create!(code: 'USD')
    language = Language.create!(name: 'English', code: 'EN')
    language2 = Language.create!(name: 'Spanish', code: 'SP')

    country = Country.create!(name: 'United States', code: 'US', side_of_road: 'right', currency: currency)

    country.languages << language
    country.languages << language2

    visit admin_country_path(country)

    expect(page).to have_content(country.name)
    expect(page).to have_content(country.code)
    expect(page).to have_content(country.side_of_road.capitalize)

    expect(page).to have_content(currency.code)
    expect(page).to have_content(language.name)
    expect(page).to have_content(language2.name)
  end
end