require 'rails_helper'

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
  end

  describe 'similar_movies' do
    it 'returns a list of similar movies' do
      VCR.use_cassette('similar_movies') do
        result = TMDBInteraction.movie_details(343_611)
        expect(result[:similar][:results].count).to eq(20)
        expect(result[:similar][:results].first).to have_key(:title)
        expect(result[:similar][:results].first).to have_key(:overview)
        expect(result[:similar][:results].last).to have_key(:popularity)
      end
    end
  end
end
