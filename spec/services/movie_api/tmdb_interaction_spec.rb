require 'rails_helper'
require './app/services/movie_api/tmdb_interaction'

describe TMDBInteraction do
  describe 'search_tmdb' do
    it 'good query' do
      VCR.use_cassette('movie_search') do
        results = TMDBInteraction.search_tmdb('the')
        expect(results.first.id).to eq(120)
        expect(results.first).to be_a(MovieData)
      end
    end

    it 'no results' do
      VCR.use_cassette('movie_search_no_results') do
        expect(TMDBInteraction.search_tmdb('adhfaosdjfaodihf;aldohfasdihfoidhfdj')).to be_empty
      end
    end

    it 'search results less than 40' do
      VCR.use_cassette('movie_search_less_than_40') do
        results = TMDBInteraction.search_tmdb('harry potter and the')
        expect(results.count).to be < 40
      end
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
      VCR.use_cassette('find_movie_by_id') do
        results = TMDBInteraction.movie_by_id(400_160).title
        expect(results).to eq('The SpongeBob Movie: Sponge on the Run')
      end
    end
  end

  describe 'movie_reviews' do
    before :each do
      VCR.use_cassette('movie_reviews') do
        @result = TMDBInteraction.movie_reviews(343_611)
      end
    end

    it 'finds all movie reviews' do
      expect(@result.length).to eq(3)
      expect(@result.first.author).to eq('TopKek')
    end
  end

  describe 'movie_cast' do
    before :each do
      VCR.use_cassette('movie_cast') do
        @result = TMDBInteraction.movie_cast(343_611)
      end
    end

    it 'finds first 10 cast members' do
      expect(@result.length).to eq(60)
      expect(@result.first.name).to eq('Tom Cruise')
    end

    it 'can limit number of casts members returned' do
      VCR.use_cassette('movie_cast') do
        @result = TMDBInteraction.movie_cast(343_611, 10)
      end
      expect(@result.length).to eq(10)
    end
  end

  describe 'top_movies' do
    before :each do
      VCR.use_cassette('top_movies') do
        @result = TMDBInteraction.top_movies
      end
    end

    it 'returns top movies' do
      expect(@result.first.id).to eq(761_053)
      expect(@result.last.id).to eq(12_477)
    end

    it 'returns 40 results' do
      expect(@result.count).to eq(40)
    end

    it 'returns MovieData objects' do
      expect(@result.first).to be_a(MovieData)
      expect(@result.last).to be_a(MovieData)
    end
  end

  describe 'similar_movies' do
    it 'returns a list of similar movies' do 
      VCR.use_cassette('similar_movies') do
        @result = TMDBInteraction.similar_movies(343_611)
      end
      expect(@result.count).to eq(20)
      expect(@result.first).to be_a(MovieData)
      expect(@result.last.id).to eq(131_631)
    end
    
    it 'can limit the number returned' do
      VCR.use_cassette('limit_similar_movies') do
        @result = TMDBInteraction.similar_movies(343_611, 5)
      end
      expect(@result.count).to eq(5)
    end
  end
end
