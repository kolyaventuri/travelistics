require 'rails_helper'

describe 'User visits /account' do
  user = {
    name: 'Bob Ross',
    email: 'bob@bobross.com',
    password: 'happy_little_trees'
  }

  describe 'when logged in' do
    before(:each) do
      DatabaseCleaner.clean
      User.create!(user)
    end

    after(:each) do
      Capybara.reset_sessions!
    end

    after(:all) do
      DatabaseCleaner.clean
    end

    new_password = 'bingle_bongle'

    it 'should be able to change their password' do
      visit login_path
      fill_in 'user[email]', with: user[:email]
      fill_in 'user[password]', with: user[:password]
      click_on 'Login'

      visit account_path
      pre_updated = User.first.password

      fill_in 'user[current_password]', with: user[:password]
      fill_in 'user[password]', with: new_password
      fill_in 'user[password_confirmation]', with: new_password
      click_on 'Change Password'

      expect(User.first.password).to_not eq(pre_updated)
      expect(page).to have_content('Your password has been updated!')
    end

    it 'should require them to enter their existing password' do
      visit login_path
      fill_in 'user[email]', with: user[:email]
      fill_in 'user[password]', with: user[:password]
      click_on 'Login'

      visit account_path
      pre_updated = User.first.password

      fill_in 'user[current_password]', with: 'wrong'
      fill_in 'user[password]', with: new_password
      fill_in 'user[password_confirmation]', with: new_password
      click_on 'Change Password'

      expect(User.first.password).to eq(pre_updated)
      expect(page).to have_content('You must enter your current password first.')

    end

    it 'should require them to confirm the new password' do
      visit login_path
      fill_in 'user[email]', with: user[:email]
      fill_in 'user[password]', with: user[:password]
      click_on 'Login'

      visit account_path
      pre_updated = User.first.password

      fill_in 'user[current_password]', with: user[:password]
      fill_in 'user[password]', with: new_password
      fill_in 'user[password_confirmation]', with: 'wrong'
      click_on 'Change Password'

      expect(User.first.password).to eq(pre_updated)
      expect(page).to have_content('Passwords must match.')

    end
  end
end
