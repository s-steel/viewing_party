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
      expect(page).to have_content('Vote Average:')
      expect(page).to have_content('Runtime:')
      expect(page).to have_content('Genre(s):')
      expect(page).to have_content('Summary')
      expect(page).to have_content('Cast')
      expect(page).to have_content('3 Reviews')
      expect(page).to have_content('8.0')
      expect(page).to have_content('1 hr 35 min')
      expect(page).to have_content('Animation, Fantasy, Adventure, Comedy, Family')
      expect(page).to have_content('When his best friend Gary is suddenly snatched away, SpongeBob takes Patrick on a madcap mission far beyond Bikini Bottom to save their pink-shelled pal.')
      # List the first 10 cast members (characters&actress/actors)
      # Each review's author and information
    end
  end
end
