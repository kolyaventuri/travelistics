require 'rails_helper'

describe 'Someone visiting a trip as' do
  before(:all) do
    DatabaseCleaner.clean
    @user = User.create!(
      name: 'Bob Ross',
      email: 'bob@bobross.org',
      password: 'happy_little_trees'
    )


    @user2 = User.create!(
      name: 'Bernard',
      email: 'benny_who_likes_cats@gmail.com',
      password: 'knowing_megamind'
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


    @trip = Trip.create!(
      name: 'Mexican vacation!',
      origin_country: @country,
      destination_country: @country2,
      user: @user
    )
  end

  after(:all) do
    DatabaseCleaner.clean
  end

  describe 'a logged in user' do
    scenario 'can see the trip details' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit trip_path(@trip)
      expect(page).to have_content(@trip.name)
      expect(page).to have_content(@trip.origin_country.name)
      expect(page).to have_content(@trip.destination_country.name)
    end

    scenario 'is directed back to their trips page' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user2)

      visit trip_path(@trip)
      expect(page).to_not have_content(@trip.name)
      expect(current_path).to eq(trips_path)
    end
  end

  describe 'a visitor' do
    scenario 'is redirected to the login page' do
      visit trip_path(@trip)

      expect(current_path).to eq(login_path)
    end
  end
end
