require 'rails_helper'

describe 'As a user that is logged in' do
  describe 'I can log out' do
    it 'I click logout and am returned to the welcome page' do
      @user = User.create!(email: 'me@email.com',
                           password: 'password',
                           password_confirmation: 'password')

      visit root_path

      fill_in 'email', with: @user.email.to_s
      fill_in 'password', with: @user.password.to_s
      click_button 'Sign In'
      expect(page).to have_content("Welcome #{@user.user_name}!")
      click_button 'Logout'
      expect(current_path).to eq(root_path)
      expect(page).to have_content('You are now logged out!')
      expect(page).to_not have_content("Welcome #{@user.user_name}!")
    end
  end
end
