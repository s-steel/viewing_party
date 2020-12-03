require 'rails_helper'

RSpec.describe 'As a registered user' do
  describe 'when I visit the discover path' do
    before :each do
      @user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit discover_path
    end
    
    it 'I see a Discover top 40 movies button' do
      expect(page).to have_button('Discover Top 40 Movies')
    end

    it 'I see a text field and button to search by movie title' do
      expect(page).to have_field(:query)
      expect(page).to have_button('Find Movies')
    end

    describe 'when I click on the Discover Top 40 Movies button' do
      before :each do 
        VCR.use_cassette('top_movies') do
          click_button 'Discover Top 40 Movies'
        end
      end

      it 'I am taken to the movies page and see the top 40 movies' do
        sample_data =
          {
              "adult" => false,
              "backdrop_path" => "/fQq1FWp1rC89xDrRMuyFJdFUdMd.jpg",
              "genre_ids" => [],
              "id" => 761053,
              "original_language" => "en",
              "original_title" => "Gabriel's Inferno Part III",
              "overview" => "The final part of the film adaption of the erotic romance novel Gabriel's Inferno written by an anonymous Canadian author under the pen name Sylvain Reynard.",
              "popularity" => 37.015,
              "poster_path" => "/qtX2Fg9MTmrbgN1UUvGoCsImTM8.jpg",
              "release_date" => "2020-11-19",
              "title" => "Gabriel's Inferno Part III",
              "video" => false,
              "vote_average" => 9.3,
              "vote_count" => 445
          }

        expect(current_path).to eq(movies_path)
        expect(page).to have_css('.movie-block', count:40)
        expect(page).to have_css("#api-id-#{sample_data['id']}", count:1)
      end

      it 'I still see a top rated movies button and search movie by title field and button' do
        expect(page).to have_button('Discover Top 40 Movies')
        expect(page).to have_field(:query)
        expect(page).to have_button('Find Movies')
      end
      
    end
  end
end