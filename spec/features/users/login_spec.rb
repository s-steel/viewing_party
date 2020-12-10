require 'rails_helper'

describe 'Log In' do
  describe 'A user visits the welcome page and attempts to log in' do
    before :each do
      @user = User.create!(email: 'me@email.com',
                           password: 'password',
                           password_confirmation: 'password')
    end

    context 'with valid information' do
      before(:each) { visit '/' }

      it 'I am a regular user, I log in and am redirected to my dashboard' do
        fill_in 'email', with: @user.email.to_s
        fill_in 'password', with: @user.password.to_s
        click_button 'Sign In'

        expect(current_path).to eq('/dashboard')
        expect(page).to have_content('Welcome me!')
      end
    end

    context 'with invalid information' do
      before(:each) { visit '/' }

      it 'I enter invalid email' do
        fill_in 'email', with: 'you@email.com'
        fill_in 'password', with: @user.password.to_s
        click_button 'Sign In'
        expect(current_path).to eq(root_path)
        expect(page).to have_content('Invalid email or password, please try again.')
      end

      it 'I enter invalid password' do
        fill_in 'email', with: @user.email.to_s
        fill_in 'password', with: 'other_password'
        click_button 'Sign In'
        expect(current_path).to eq(root_path)
        expect(page).to have_content('Invalid email or password, please try again.')
      end

      it 'I leave the password field blank' do
        fill_in 'email', with: @user.email.to_s
        fill_in 'password', with: ''
        click_button 'Sign In'
        expect(current_path).to eq(root_path)
        expect(page).to have_content('Invalid email or password, please try again.')
      end

      it 'I leave the email field blank' do
        fill_in 'email', with: ''
        fill_in 'password', with: @user.password.to_s
        click_button 'Sign In'
        expect(current_path).to eq(root_path)
        expect(page).to have_content('Invalid email or password, please try again.')
      end
    end
  end
end
