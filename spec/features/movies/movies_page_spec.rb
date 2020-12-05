require 'rails_helper'

describe 'I try to visit the movies page' do
  describe 'As an authenticated user' do
    before :each do
      @user = User.new(email: 'me@email.com',
                       password: 'password')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'I see the title and rating of the top 40 movies from my search' do
      VCR.use_cassette('movie_search') do
        visit '/movies?&query=the'

        expect(page).to have_css('.movie-block', count: 40)

        within('#api-id-400160') do
          expect(page).to have_content('The SpongeBob Movie: Sponge on the Run')
          expect(page).to have_content('8')
        end
      end
    end

    it 'I see an error if I search using an empty query' do
      visit '/movies?&query='

      expect(page).to_not have_css('.movie-block')
      expect(page).to have_content('Must enter a movie title as search query')
    end

    it 'can click movie title link and am taken to that movie show page' do
      VCR.use_cassette('movie_show_page') do
        visit '/movies?&query=the'

        within('#api-id-400160') do
          click_link('The SpongeBob Movie: Sponge on the Run')
          expect(current_path).to eq('/movies/400160')
        end
      end
    end
  end

  describe 'While not logged in' do
    it 'I see a 404 page' do
      visit '/movies?&query=the'

      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
