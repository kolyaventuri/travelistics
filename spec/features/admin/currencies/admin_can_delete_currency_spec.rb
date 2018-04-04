require 'rails_helper'

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
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit admin_currencies_path

    within('.currencies') do
      expect(page).to have_content(@currency1.code)
      expect(page).to have_content(@currency2.code)
    end

    within("#currency_#{@currency1.id}") do
      click_on 'Delete'
    end

    expect(current_path).to eq(admin_currencies_path)
    within('.currencies') do
      expect(page).to have_content(@currency2.code)
      expect(page).to_not have_content(@currency1.code)
    end
  end
end