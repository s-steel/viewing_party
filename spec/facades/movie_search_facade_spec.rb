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

      expect(result).to be_a(MovieData)
    end

    it 'creates nested actor objects', :vcr do
      result = MovieSearchFacade.movie_details(121)
      
      expect(result.cast).to be_a(Array)
      expect(result.cast.first).to be_a(Actor)
    end

    it 'creates nested review objects', :vcr do
      result = MovieSearchFacade.movie_details(121)
      
      expect(result.see_reviews).to be_a(Array)
      expect(result.see_reviews.first).to be_a(Review)
    end

    it 'can limit the number of returned actors to 10', :vcr do
      result = MovieSearchFacade.movie_details(121)

      expect(result.cast.count).to eq(10)
    end
  end

end
