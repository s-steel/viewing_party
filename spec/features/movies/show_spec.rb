require 'rails_helper'

describe 'Movies show page' do
  describe 'As an authenticated user, when I visit the movies detail page' do
    before :each do
      @user = User.new(email: 'me@email.com',
                       password: 'password')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'has a button to create a viewing party' do
      VCR.use_cassette('movie_by_id') do
        visit '/movies/400160'
        click_button('Create Viewing Party for this Movie')
        expect(current_path).to eq('/viewing-party/new')
      end
    end
  end

  describe 'movie by id api call' do
    before :each do
      @user = User.new(email: 'me@email.com',
                       password: 'password')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'show all the info about the movie' do
      VCR.use_cassette('find_movie_by_id') do
        visit '/movies/400160'
        expect(page).to have_css('.new-viewing-button')
        expect(page).to have_css('.movie-title', count: 1)
        title = find('.movie-title').text
        expect(title).to_not be_empty
        expect(page).to have_content('The SpongeBob Movie: Sponge on the Run')

        expect(page).to have_css('.movie-data', count: 1)
        data = find('.movie-data').text
        expect(data).to_not be_empty
        expect(page).to have_content('Vote Average:')
        expect(page).to have_content('Runtime:')
        expect(page).to have_content('Genre(s):')
        expect(page).to have_content('8.0')
        expect(page).to have_content('1 hr 35 min')
        expect(page).to have_content('Animation, Fantasy, Adventure, Comedy, Family')

        expect(page).to have_css('.movie-summary', count: 1)
        summary = find('.movie-summary').text
        expect(summary).to_not be_empty
        expect(page).to have_content('Summary')
        expect(page).to have_content('When his best friend Gary is suddenly snatched away, SpongeBob takes Patrick on a madcap mission far beyond Bikini Bottom to save their pink-shelled pal.')

        expect(page).to have_css('.movie-cast', count: 1)
        cast = find('.movie-cast').text
        expect(cast).to_not be_empty
        expect(page).to have_content('Cast')

        expect(page).to have_css('.movie-reviews', count: 1)
        reviews = find('.movie-reviews').text
        expect(reviews).to_not be_empty
        expect(page).to have_content('1 Reviews')
        expect(page).to have_content('Author:')

        within '#review-5fa63d658c7b0f003f785d60' do
          expect(page).to have_content('SWITCH.')
          expect(page).to have_content('Thanks to its meme resurgence, a surprisingly successful musical')
        end
      end
    end
  end

  describe 'similar movie api call' do
    before :each do
      @user = User.new(email: 'me@email.com',
                       password: 'password')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'show similar movies' do
      VCR.use_cassette('similar_movies') do
        visit '/movies/343611'
        expect(page).to have_css('.similar-movies', count: 1)
        similar_movies = find('.similar-movies').text
        expect(similar_movies).to_not be_empty
      end
    end
  end
end
