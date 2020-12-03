require 'rails_helper'
require './app/services/movie_api/tmdb_interaction'

describe TMDBInteraction do
  describe 'search_tmdb' do
    it 'good query' do
      expect(TMDBInteraction.search_tmdb('the')[0].id).to eq(120)
    end

    it 'no results' do
      expect(TMDBInteraction.search_tmdb('adhfaosdjfaodihf;aldohfasdihfoidhfdj')).to eq([])
    end
  end

  describe 'create_movie_data' do
    it do
      example_data = [
        {
          'vote_average' => 8,
          'popularity' => 737.45,
          'id' => 400_160,
          'release_date' => '2020-08-14',
          'adult' => false,
          'backdrop_path' => '/wu1uilmhM4TdluKi2ytfz8gidHf.jpg',
          'vote_count' => 1620,
          'genre_ids' => [
            16,
            14,
            12,
            35,
            10_751
          ],
          'title' => 'The SpongeBob Movie => Sponge on the Run',
          'original_language' => 'en',
          'original_title' => 'The SpongeBob Movie => Sponge on the Run',
          'poster_path' => '/jlJ8nDhMhCYJuzOw3f52CP1W8MW.jpg',
          'overview' => 'When his best friend Gary is suddenly snatched away, SpongeBob takes Patrick on a madcap mission far beyond Bikini Bottom to save their pink-shelled pal.',
          'video' => false
        }
      ]

      result = TMDBInteraction.create_movie_data(example_data)

      expect(result[0]).to be_a(MovieData)

      expect(result[0].id).to eq(400_160)
    end
  end

  # describe 'get 40 results' do
  #   it do

  #   end
  # end

    describe 'top_movies' do
      it do
        sample_data = [
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
        ]
        result = TMDBInteraction.top_movies
        
        expect(result.first).to be_a(MovieData)

        expect(result.first.id).to eq(sample_data.first['id'])
      end
    end
end
