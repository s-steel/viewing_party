require 'rails_helper'

describe 'Log In' do 
  describe 'A user visits the welcome page and attempts to log in' do
    before :each do
      @user = User.create!(email: 'me@email.com',
                           password: 'password')
      visit '/'
    end

    context 'with valid information' do 
      it 'I am a regular user I log in and am redirected to my dashboard' do
        fill_in 'email', with: "#{@user.email}"
        fill_in 'password', with: "#{@user.password}"
        click_button 'Sign In'

        expect(current_path).to eq('/dashboard')
        expect(page).to have_content("Welcome #{@user.email}!")
      end
    end
  end
end