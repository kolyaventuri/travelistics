require 'rails_helper'

describe 'Authorization' do
  before(:all) do
    DatabaseCleaner.clean
    @language = Language.create!(name: 'English', code: 'USD')
  end

  after(:all) do
    DatabaseCleaner.clean
  end

  describe 'an admin' do
    scenario 'can access the language edit page' do
      user = User.create!(
        name: 'Bob Ross',
        email: 'bob@bobross.com',
        password: 'happy_little_trees',
        role: 1
      )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit edit_admin_language_path(@language)
      expect(page).to have_content("Editing #{@language.name}")
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

      visit edit_admin_language_path(@language)
      expect(page).to_not have_content("Editing #{@language.name}")
      expect(page).to have_content('The page you were looking for doesn\'t exist.')
    end
  end
end

describe 'Admin' do
  before(:all) do
    DatabaseCleaner.clean

    @language = Language.create!(name: 'English', code: 'EN')

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

  scenario 'can edit a language' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit admin_languages_path

    within("#language_#{@language.id}") do
      click_on 'Edit'
    end

    expect(current_path).to eq(edit_admin_language_path(@language))
    expect(page).to have_content(@language.name)

    new_name = 'Spanish'
    new_code = 'SP'

    fill_in 'language[name]', with: new_name
    fill_in 'language[code]', with: new_code

    click_on 'Update Language'

    expect(current_path).to eq(admin_languages_path)
    expect(page).to have_content(new_name)
    expect(page).to_not have_content(@language.name)
  end
end