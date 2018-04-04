require 'rails_helper'

describe 'Authorization' do
  before(:all) do
    DatabaseCleaner.clean
    @currency = Currency.create!(code: 'USD')
  end

  after(:all) do
    DatabaseCleaner.clean
  end

  describe 'an admin' do
    scenario 'can access the currency edit page' do
      user = User.create!(
        name: 'Bob Ross',
        email: 'bob@bobross.com',
        password: 'happy_little_trees',
        role: 1
      )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit edit_admin_currency_path(@currency)
      expect(page).to have_content("Editing #{@currency.code}")
    end
  end

  describe 'a regular user' do
    scenario 'cannot access the currency edit page' do
      user = User.create!(
        name: 'Bob Ross',
        email: 'bob@bobross.com',
        password: 'happy_little_trees',
        role: 0
      )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit edit_admin_currency_path(@currency)
      expect(page).to_not have_content("Editing #{@currency.code}")
      expect(page).to have_content('The page you were looking for doesn\'t exist.')
    end
  end
end

describe 'Admin' do
  before(:all) do
    DatabaseCleaner.clean

    @currency1 = Currency.create!(code: 'USD')
    @currency2 = Currency.create!(code: 'GBP')

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

  scenario 'can edit a currency' do
    new_code = 'RUB'

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit admin_currencies_path

    within('.currencies') do
      expect(page).to have_content(@currency1.code)
      expect(page).to have_content(@currency2.code)
    end

    within("#curreny_#{@currency1.id}") do
      click_on 'Edit'
    end

    expect(current_path).to eq(edit_admin_currency_path(@currency1))

    fill_in 'currency[code]', with: new_code
    click_on 'Update Currency'

    expect(current_path).to eq(admin_currencies_path)
    expect(page).to have_content(new_code)
    expect(page).to_not have_content(@currency1.code)
  end
end