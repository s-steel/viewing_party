require 'rails_helper'

describe 'movie_search_facade' do
  describe 'top_movies' do
    it 'creates movie data objects', :vcr do
      result = MovieSearchFacade.top_movies

      expect(result).to be_a(Array)
      expect(result.first).to be_a(MovieData)
    end
  end

  describe 'search_tmdb' do
    it 'creates movie data objects', :vcr do
      result = MovieSearchFacade.search_tmdb('the lord of the rings')

      expect(result).to be_a(Array)
      expect(result.first).to be_a(MovieData)
    end
  end

  describe 'movie_details' do
    it 'creates movie data object', :vcr do
      result = MovieSearchFacade.movie_details(121)

      expect(result[:movie]).to be_a(MovieData)
    end

    it 'creates actor objects', :vcr do
      result = MovieSearchFacade.movie_details(121)

      expect(result[:cast]).to be_a(Array)
      expect(result[:cast].first).to be_a(Actor)
    end

    it 'creates review objects', :vcr do
      result = MovieSearchFacade.movie_details(121)

      expect(result[:reviews]).to be_a(Array)
      expect(result[:reviews].first).to be_a(Review)
    end

    it 'can limit the number of returned actors to 10', :vcr do
      result = MovieSearchFacade.movie_details(121)

      expect(result[:cast].count).to eq(10)
    end
  end

  describe 'similar_movies' do
    it 'creates movie data object', :vcr do
      result = MovieSearchFacade.movie_details(121)
      expect(result[:similar_movies]).to be_a(Array)
      expect(result[:similar_movies].first).to be_a(MovieData)
    end

    it 'can limit the number of objects returned', :vcr do
      result = MovieSearchFacade.movie_details(121, 8)

      expect(result[:similar_movies].length).to be(8)
    end
  end
end
