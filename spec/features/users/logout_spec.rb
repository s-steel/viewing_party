require 'rails_helper'

describe 'As a user that is logged in' do 
  describe 'I can log out' do
    it 'I click logout and am returned to the welcome page' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit dashboard_path
      expect(page).to have_content("Welcome #{user.user_name}!")
      click_button 'Logout'
      visit root_path
      expect(current_path).to eq(root_path)
      expect(page).to have_content('You are now logged out!')
      expect(page).to_not have_content("Welcome #{user.user_name}!")
    end
  end
end