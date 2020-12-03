require 'rails_helper'

describe 'Movies show page' do
  describe 'As an authenticated user, when I visit the movies detail page' do
    before :each do
      @user = User.new(email: 'me@email.com',
        password: 'password')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit '/movies/400160'
    end

    it 'has a button to create a viewing party' do
      click_button('Create Viewing Party for this Movie')
      expect(current_path).to eq('/viewing-party/new')
    end

    it 'show all the info about the movie' do
      expect(page).to have_content('The SpongeBob Movie: Sponge on the Run')
      # Vote Average of the movie
      # Runtime in hours & minutes
      # Genere(s) associated to movie
      # Summary description
      # List the first 10 cast members (characters&actress/actors)
      # Count of total reviews
      # Each review's author and information
    end
  end
end
