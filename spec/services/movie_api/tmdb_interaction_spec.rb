require 'rails_helper'
require './app/services/movie_api/tmdb_interaction'

describe TMDBInteraction do
  describe 'search_tmdb' do
    it 'good query' do
      expect(TMDBInteraction.search_tmdb('the')[0].id).to eq(400_160)
    end

    it 'no results' do
      expect(TMDBInteraction.search_tmdb('adhfaosdjfaodihf;aldohfasdihfoidhfdj')).to eq([])
    end
  end
end
