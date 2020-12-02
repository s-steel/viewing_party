require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'when I visit the registration form' do
    it 'I see fields for email, password, password confirmation, and a register button' do
      visit new_registration_path 

      expect(page).to have_field('user[email]')
      expect(page).to have_field('user[password]')
      expect(page).to have_field('user[password_confirmation]')
      expect(page).to have_button('Register')
    end

    describe 'when I click the register button' do 
      before :each do 
          @user = build(:user)
          @user_name = @user.user_name
          visit new_registration_path 
      end 

      it 'with completed fields and unique email, I am logged in and redirected to my dashboard' do 
        fill_in 'user[email]', with: @user.email 
        fill_in 'user[password]', with: @user.password
        fill_in 'user[password_confirmation]', with: @user.password_confirmation
        click_button 'Register'
        expect(current_path).to eq(dashboard_path)
        expect(page).to have_content("Welcome #{@user_name}!")
      end
      
      it 'with one orq more incomplete fields, I see an error message on the registration form' do
        fill_in 'user[email]', with: @user.email 
        click_button 'Register'
        expect(find_field('user[email]').value).to eq(@user.email)
        expect(find_field('user[password]').value).to eq(nil)
        expect(page).to have_content("Password confirmation can't be blank and Password can't be blank")
        
        fill_in 'user[password]', with: @user.password
        click_button 'Register'
        expect(find_field('user[password]').value).to eq(nil)
        expect(page).to have_content("Password confirmation doesn't match Password")
      end

      it 'if I try registering with an existing email, I see an error message and stay on the form' do
        
      end

      it 'if my passwords do not match, I receive a see an error message and stay on the form' do
        
      end
    end
  end
end