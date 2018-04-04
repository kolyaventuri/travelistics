require 'rails_helper'

describe 'Authorization' do
  before(:all) do
    DatabaseCleaner.clean
  end

  after(:all) do
    DatabaseCleaner.clean
  end

  describe 'an admin' do
    scenario 'can access the language create page' do
      user = User.create!(
        name: 'Bob Ross',
        email: 'bob@bobross.com',
        password: 'happy_little_trees',
        role: 1
      )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit new_admin_language_path
      expect(page).to have_content('Create a Language')
    end
  end

  describe 'a regular user' do
    scenario 'cannot access languages create page' do
      user = User.create!(
        name: 'Bob Ross',
        email: 'bob@bobross.com',
        password: 'happy_little_trees',
        role: 0
      )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      vvisit new_admin_language_path
      expect(page).to_not have_content('Create a Language')
      expect(page).to have_content('The page you were looking for doesn\'t exist.')
    end
  end
end

describe 'Admin' do
  before(:all) do
    DatabaseCleaner.clean

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

  scenario 'can create a language' do
    new_name = 'Spanish'
    new_code = 'SP'

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit admin_languages_path

    expect(page).to_not have_content(new_name)

    click_on 'Add a Language'

    expect(current_path).to eq(new_admin_language_path)

    fill_in 'language[name]', with: new_name
    fill_in 'language[code]', with: new_code

    click_on 'Create Language'

    expect(current_path).to eq(admin_languages_path)
    expect(page).to have_content(new_name)
  end
end