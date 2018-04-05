require 'rails_helper'

describe 'User visits page for travel to two countries' do
  before(:all) do
    DatabaseCleaner.clean
    @currency = Currency.create!(code: 'USD')
    @currency2 = Currency.create!(code: 'MEX')

    @language = Language.create!(name: 'English', code: 'EN')
    @language2 = Language.create!(name: 'Spanish', code: 'SP')

    @country = Country.create!(name: 'United States', code: 'US', side_of_road: 'right', currency: @currency)
    @country2 = Country.create!(name: 'Mexico', code: 'MX', side_of_road: 'right', currency: @currency2)
    @country3 = Country.create!(name: 'England', code: 'GB', side_of_road: 'left', currency: @currency)

    @country.languages.push(@language)
    @country2.languages.push(@language2)

    @country3.languages.push(@language2)
    @country3.languages.push(@language)
  end

  after(:all) do
    DatabaseCleaner.clean
  end

  scenario 'sees the data for those two countries' do
    visit "/travel/#{@country.code}/#{@country2.code}"

    expect(page).to have_content("Traveling from #{@country.name} to #{@country2.name}")

    expect(page).to have_content("#{@country2.name} uses the #{@country2.currency.code}")

    expect(page).to have_content("#{@country2.name} speaks #{@country2.languages.first.name}")
  end

  scenario 'sees the data for a country with similar information' do
    visit "/travel/#{@country.code}/#{@country3.code}"

    expect(page).to have_content("Traveling from #{@country.name} to #{@country3.name}")

    expect(page).to have_content("#{@country3.name} also uses the #{@country3.currency.code}")

    expect(page).to have_content("#{@country3.name} speaks #{@country3.languages.first.name} and #{@country3.languages.last.name}")
  end
end