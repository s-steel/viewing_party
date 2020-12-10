require 'rails_helper'

describe 'Welcome Page' do
  describe 'When a user visits the root path they will be on the welcome page' do
    before(:each) { visit '/' }

    it 'includes a welcome message' do
      expect(page).to have_content('Welcome To The Viewing Party!')
    end

    it 'has brief description of app' do
      expect(page).to have_content('This app allows you to explore a library of movies and then create a viewing party event where you can invite all your friends to watch a movie together!')
    end

    it 'has fields and button to login' do
      expect(page).to have_field('email')
      expect(page).to have_field('password')
      expect(page).to have_button('Sign In')
    end

    it 'has link to registration' do
      expect(page).to have_link('New to Viewing Party? Register Here')
    end

    it 'does not have a button to the dashboard' do
      expect(page).to_not have_button('Dashboard')
    end
  end
end
