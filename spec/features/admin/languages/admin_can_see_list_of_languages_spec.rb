require 'rails_helper'

describe 'Authorization' do
  describe 'an admin' do
    scenario 'can access the languages list' do
      user = User.create!(
        name: 'Bob Ross',
        email: 'bob@bobross.com',
        password: 'happy_little_trees',
        role: 1
      )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit admin_languages_path
      expect(page).to have_content('Languages')
    end
  end

  describe 'a regular user' do
    scenario 'cannot access languages list' do
      user = User.create!(
        name: 'Bob Ross',
        email: 'bob@bobross.com',
        password: 'happy_little_trees',
        role: 0
      )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit admin_languages_path
      expect(page).to_not have_content('Languages')
      expect(page).to have_content('The page you were looking for doesn\'t exist.')
    end
  end
end

describe 'Admin' do
  before(:all) do
    DatabaseCleaner.clean

    language1 = Language.create!(name: 'English', code: 'EN')
    language2 = Language.create!(name: 'Spanish', code: 'SP')
    language3 = Language.create!(name: 'Russian', code: 'RU')

    @languages = [@language1, @language2, @language3]
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

  scenario 'can see list of languages' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit admin_languages_path

    within('.languages') do
      @languages.each do |currency|
        expect(page).to have_content(currency.code)
      end
    end
  end
end