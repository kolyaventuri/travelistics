require 'rails_helper'

describe 'User visits /trips' do
  before(:all) do
    DatabaseCleaner.clean
    @user = User.create!(
      name: 'Bob Ross',
      email: 'bob@bobross.org',
      password: 'happy_little_trees'
    )
    currency = Currency.create!(code: 'USD')
    @country = Country.create!(
      name: 'United States of America',
      code: 'US',
      side_of_road: 'right',
      currency: currency
    )
    @country2 = Country.create!(
      name: 'Mexico',
      code: 'MX',
      side_of_road: 'right',
      currency: currency
    )


    @trip1 = Trip.create!(
      name: 'Mexican vacation!',
      origin_country: @country,
      destination_country: @country2,
      user: @user
    )
    @trip2 = Trip.create!(
      name: 'Back home',
      origin_country: @country2,
      destination_country: @country,
      user: @user
    )
  end

  after(:all) do
    DatabaseCleaner.clean
  end

  scenario 'they can delete a trip' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit trips_path

    within('.trips') do
      expect(page).to have_content("#{@country.name} to #{@country2.name}")
      expect(page).to have_content("#{@country2.name} to #{@country.name}")

      within("#trip_#{@trip1.id}") do
        find('a.delete').click
      end
    end

    expect(current_path).to eq(trips_path)

    within('.trips') do
      expect(page).to_not have_content("#{@country.name} to #{@country2.name}")
      expect(page).to have_content("#{@country2.name} to #{@country.name}")
    end
  end
end
