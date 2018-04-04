require 'rails_helper'

describe 'Admin' do
  before(:all) do
    DatabaseCleaner.clean
    @currency = Currency.create!(code: 'USD')
    @currency2 = Currency.create!(code: 'RUB')
    @language = Language.create!(name: 'English', code: 'EN')
    @language2 = Language.create!(name: 'Spanish', code: 'SP')

    @country = Country.create!(name: 'United States', code: 'US', side_of_road: 'right', currency: @currency)
    @country2 = Country.create!(name: 'Russia', code: 'RU', side_of_road: 'right', currency: @currency2)

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

  scenario 'can delete a country' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit admin_countries_path

    within('.countries') do
      expect(page).to have_content(@country.name)
      expect(page).to have_content(@country2.name)
    end

    visit edit_admin_country_path(@country)

    click_on 'Delete'

    expect(current_path).to eq(admin_countries_paths)
    within('.countries') do
      expect(page).to_not have_content(@country.name)
      expect(page).to have_content(@country2.name)
    end
  end
end