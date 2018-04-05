require 'rails_helper'

describe 'Admin' do
  before(:all) do
    DatabaseCleaner.clean

    language1 = Language.create!(name: 'English', code: 'EN')
    language2 = Language.create!(name: 'Spanish', code: 'SP')
    language3 = Language.create!(name: 'Russian', code: 'RU')

    @languages = [language1, language2, language3]
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

  scenario 'can delete a language' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit admin_languages_path

    within('.languages') do
      @languages.each do |language|
        expect(page).to have_content(language.code)
      end
    end

    within("#language_#{@languages[0].id}") do
      click_on 'Delete'
    end

    expect(current_path).to eq(admin_languages_path)
    expect(page).to have_content(@languages[1].name)
    expect(page).to have_content(@languages[2].name)

    expect(page).to_not have_content(@languages[0].name)
  end
end