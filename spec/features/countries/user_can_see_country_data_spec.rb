require 'rails_helper'

describe 'User visiting a country page' do
  before(:all) do
    DatabaseCleaner.clean
  end

  after(:all) do
    DatabaseCleaner.clean
  end

  scenario 'should see that countries information' do
    country = Country.create!(name: 'United States of America', code: 'US', side_of_road: 0)

    visit country_path(country)

    expect(page).to have_content(country.name)
    expect(page).to have_content('Right side of road')
  end
end