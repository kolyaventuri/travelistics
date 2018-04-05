require 'rails_helper'

describe 'Authorization' do
  before(:all) do
    DatabaseCleaner.clean
    @currency = Currency.create!(code: 'USD')
    @currency2 = Currency.create!(code: 'GBP')
    @language = Language.create!(name: 'English', code: 'EN')
    @language2 = Language.create!(name: 'Spanish', code: 'SP')

    @country = Country.create!(name: 'United States', code: 'US', side_of_road: 'right', currency: @currency)

    @country.languages.push(@language)
  end

  after(:all) do
    DatabaseCleaner.clean
  end

  describe 'an admin' do
    scenario 'can access the admin countries list' do
      user = User.create!(
        name: 'Bob Ross',
        email: 'bob@bobross.com',
        password: 'happy_little_trees',
        role: 1
      )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit admin_countries_path
      expect(page).to have_content(@country.name)
    end
  end

  describe 'a regular user' do
    scenario 'cannot access admin country list' do
      user = User.create!(
        name: 'Bob Ross',
        email: 'bob@bobross.com',
        password: 'happy_little_trees',
        role: 0
      )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit admin_countries_path
      expect(page).to_not have_content(@country.name)
      expect(page).to have_content('The page you were looking for doesn\'t exist.')
    end
  end
end

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

    country1 = Country.create!(name: 'United States', code: 'US', side_of_road: 'right', currency: currency)
    country2 = Country.create!(name: 'Germany', code: 'DE', side_of_road: 'right', currency: currency)

    visit admin_countries_path

    expect(page).to have_content('Countries')
    within('.countries') do
      expect(page).to have_content(country1.name)
      expect(page).to have_content(country2.name)
    end

    click_on country1.name

    expect(current_path).to eq(admin_country_path(country1))

    expect(page).to have_content(country1.name)
  end
end