require 'rails_helper'

describe 'User visits page for travel to two countries' do
  before(:all) do
    DatabaseCleaner.clean
    @user = User.create!(
      name: 'Bob Ross',
      email: 'bob@bobross.org',
      password: 'happy_little_trees'
    )

    @currency = Currency.create!(code: 'USD')
    @currency2 = Currency.create!(code: 'MEX')

    @language = Language.create!(name: 'English', code: 'EN')
    @language2 = Language.create!(name: 'Spanish', code: 'SP')

    @country = Country.create!(name: 'United States', code: 'US', side_of_road: 'right', currency: @currency)
    @country2 = Country.create!(name: 'Mexico', code: 'MX', side_of_road: 'right', currency: @currency2)

    @country.languages.push(@language)
    @country2.languages.push(@language2)
  end

  after(:all) do
    DatabaseCleaner.clean
  end

  describe 'if logged in' do
    scenario 'can save the trip to their trips' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit trips_path

      expect(page).to_not have_content("#{@country.name} to #{@country2.name}")

      visit travel_path(@country.code, @country2.code)

      click_on 'Save to My Trips'

      expect(current_path).to eq(trips_path)

      expect(page).to have_content("#{@country.name} to #{@country2.name}")
    end
  end

  describe 'if not logged in' do
    scenario 'should not see the save to trips link' do
      visit travel_path(@country.code, @country2.code)

      expect(page).to_not have_content('Save to My Trips')
    end
  end
end