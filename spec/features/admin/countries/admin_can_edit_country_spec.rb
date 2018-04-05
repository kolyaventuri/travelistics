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
    scenario 'can edit the admin country data' do
      user = User.create!(
        name: 'Bob Ross',
        email: 'bob@bobross.com',
        password: 'happy_little_trees',
        role: 1
      )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit edit_admin_country_path(@country)
      expect(page).to have_content(@country.name)
    end
  end

  describe 'a regular user' do
    scenario 'cannot edit admin country data' do
      user = User.create!(
        name: 'Bob Ross',
        email: 'bob@bobross.com',
        password: 'happy_little_trees',
        role: 0
      )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit edit_admin_country_path(@country)
      expect(page).to_not have_content(@country.name)
      expect(page).to have_content('The page you were looking for doesn\'t exist.')
    end
  end
end

describe 'Admin' do
  before(:all) do
    DatabaseCleaner.clean
    @user = User.new(
      name: 'Bob Ross',
      email: 'bob@bobross.com',
      password: 'happy_little_trees',
      role: 1
    )
  end

  before(:each) do
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

  new_data = {
    name: 'Germany',
    code: 'DE',
    side_of_road: 'left',
    currency: 'GBP',
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
    select @currency2.code, from: 'country[currency]'

    click_on 'Update Country'

    expect(current_path).to eq(admin_country_path(@country))
    expect(page).to have_content("#{new_data[:name]} was updated")
    expect(page).to have_content(new_data[:name])
    expect(page).to have_content(new_data[:code])
    expect(page).to have_content(new_data[:side_of_road].capitalize)
    expect(page).to have_content(new_data[:currency])
  end

  scenario 'can add language to country' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit edit_admin_country_path(@country)

    expect(page).to have_content(@language.name)
    expect(page).to_not have_content(@language2.name)

    click_on 'Add Language'

    expect(current_path).to eq(new_admin_country_language_path(@country))

    expect(page).to have_content("Add language to #{@country.name}")

    select @language2.name, from: 'language[name]'

    click_on 'Add Language'

    expect(current_path).to eq(edit_admin_country_path(@country))

    expect(page).to have_content(@language.name)
    expect(page).to have_content(@language2.name)
  end

  scenario 'can delete language from country' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit edit_admin_country_path(@country)

    expect(page).to have_content(@language.name)

    within("#language_#{@language.id}") do
      click_on 'Delete'
    end

    expect(current_path).to eq(edit_admin_country_path(@country))
    expect(page).to_not have_content(@language.name)
  end
end
