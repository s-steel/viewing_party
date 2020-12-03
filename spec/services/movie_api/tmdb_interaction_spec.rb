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

  describe 'movie_by_id' do
    it 'finds movie by id' do
      expect(TMDBInteraction.movie_by_id(400160).title).to eq('The SpongeBob Movie: Sponge on the Run')
    end
  end

  # describe 'get 40 results' do
  #   it do

  #   end
  # end
end
