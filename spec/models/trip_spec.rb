require 'rails_helper'

describe Trip, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'relationships' do
    it { is_expected.to belong_to(:origin_country) }
    it { is_expected.to belong_to(:destination_country) }

    it { is_expected.to belong_to(:user) }
  end

  describe 'attributes' do
    before(:all) do
      DatabaseCleaner.clean
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

      @user = User.create!(
        name: 'Bob Ross',
        email: 'bob@bobross.com',
        password: 'happy_little_trees',
        role: 0
      )
    end

    after(:all) do
      DatabaseCleaner.clean
    end

    it 'should be able to have an origin and destination country' do
      trip = Trip.create!(
        name: 'My Mexican Vacation',
        origin_country: @country,
        destination_country: @country2,
        user: @user
      )

      expect(trip.origin_country).to be(@country)
      expect(trip.destination_country).to be(@country2)
    end
  end
end