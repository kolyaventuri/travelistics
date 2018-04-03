require 'rails_helper'

describe 'Admin' do
  before(:all) do
    DatabaseCleaner.clean
    @user = User.create!(
      name: 'Bob Ross',
      email: 'bob@bobross.com',
      password: 'happy_little_trees',
      role: 1
    )

    @currency = Currency.create!(code: 'USD')
    @language = Language.create!(name: 'English', code: 'EN')
    @language2 = Language.create!(name: 'Spanish', code: 'SP')

    @country = Country.create!(name: 'United States', code: 'US', side_of_road: 'right', currency: @currency)

    @country.languages.push(@language)
    @country.languages.push(@language2)
  end

  after(:all) do
    DatabaseCleaner.clean
  end

  new_data = {
    name: 'Germany',
    code: 'DE',
    side_of_road: 'left',
    language: 'Spanish'
  }

  scenario 'can edit a countries basic data' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit admin_country_path(@country)

    click_on 'Edit'

    expect(current_path).to eq(edit_admin_country_path(@country))

    expect(page).to have_content("Editing #{@country.name}")

    fill_in 'country[name]', with: new_data[:name]
    fill_in 'country[code]', with: new_data[:code]
    fill_in 'country[side_of_road]', with: new_data[:side_of_road]

    click_on 'Update Country'

    expect(current_path).to eq(admin_country_path(@country))
    expect(page).to have_content("#{new_data[:name]} was updated")
    expect(page).to have_content(new_data[:name])
    expect(page).to have_content(new_data[:code])
    expect(page).to have_content(new_data[:side_of_road].capitalize)
  end
end
