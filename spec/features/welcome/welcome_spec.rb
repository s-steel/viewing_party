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

    it 'has button to login'

    it 'has link to registration'
  end
end