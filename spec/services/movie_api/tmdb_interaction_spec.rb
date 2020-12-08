require 'rails_helper'
# require './app/services/movie_api/tmdb_interaction'

describe TMDBInteraction do
  describe 'search_tmdb' do
    it 'good query with lotr', :vcr do
      results = TMDBInteraction.search_tmdb('the lord of the rings')
      expect(results.first).to have_key(:id)
      expect(results.first).to have_key(:title)
      expect(results.first).to have_key(:vote_average)
    end

    it 'no results', :vcr do
      expect(TMDBInteraction.search_tmdb('adhfaosdjfaodihf;aldohfasdihfoidhfdj')).to be_empty
    end

    it 'search results less than 40', :vcr do
      results = TMDBInteraction.search_tmdb('harry potter and the')
      expect(results.count).to be < 40
    end
  end

  # describe 'create_movie_data' do
  #   it do
  #     example_data = [
  #       {
  #         'vote_average' => 8,
  #         'popularity' => 737.45,
  #         'id' => 400_160,
  #         'release_date' => '2020-08-14',
  #         'adult' => false,
  #         'backdrop_path' => '/wu1uilmhM4TdluKi2ytfz8gidHf.jpg',
  #         'vote_count' => 1620,
  #         'genre_ids' => [
  #           16,
  #           14,
  #           12,
  #           35,
  #           10_751
  #         ],
  #         'title' => 'The SpongeBob Movie => Sponge on the Run',
  #         'original_language' => 'en',
  #         'original_title' => 'The SpongeBob Movie => Sponge on the Run',
  #         'poster_path' => '/jlJ8nDhMhCYJuzOw3f52CP1W8MW.jpg',
  #         'overview' => 'When his best friend Gary is suddenly snatched away, SpongeBob takes Patrick on a madcap mission far beyond Bikini Bottom to save their pink-shelled pal.',
  #         'video' => false
  #       }
  #     ]
  #     result = TMDBInteraction.create_movie_data(example_data)

  #     expect(result[0]).to be_a(MovieData)

  #     expect(result[0].id).to eq(400_160)
  #   end
  # end

  describe 'movie_details' do
    it 'finds movie details, including reviews and cast' do
      VCR.use_cassette('finds_movie_details') do
        result = TMDBInteraction.movie_details(400_160)
        expect(result).to have_key(:genres)
        expect(result).to have_key(:vote_average)
        expect(result).to have_key(:reviews)
        expect(result[:credits]).to have_key(:cast)
      end
    end
  end

    # refactor: poros test 
    # it 'finds first 10 cast members' do
    #   expect(@result.length).to eq(60)
    #   expect(@result.first.name).to eq('Tom Cruise')
    # end

    #refactor: facade test 
    # it 'can limit number of reviews' do
    #   VCR.use_cassette('movie_cast') do
    #     @result = TMDBInteraction.movie_cast(343_611, 10)
    #   end
    #   expect(@result.length).to eq(10)
    # end

  describe 'top_movies' do
    before :each do
      VCR.use_cassette('top_movies') do
        @result = TMDBInteraction.top_movies
      end
    end

    it 'returns top movies' do
      expect(@result.first).to have_key(:genre_ids)
      expect(@result.last).to have_key(:title)
    end

    it 'returns 40 results' do
      expect(@result.count).to eq(40)
    end

      #refactor: move to movie data 
    # it 'returns MovieData objects' do
    #   expect(@result.first).to be_a(MovieData)
    #   expect(@result.last).to be_a(MovieData)
    # end
  end
end
