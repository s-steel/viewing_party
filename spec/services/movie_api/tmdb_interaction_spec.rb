require 'rails_helper'

describe TMDBInteraction do
  describe 'search_tmdb' do
    it 'good query' do
      expect(TMDBInteraction.search_tmdb('the')[0].id).to eq(400_160)
    end

    it 'no results' do
      expect(TMDBInteraction.search_tmdb('adhfaosdjfaodihf;aldohfasdihfoidhfdj')).to eq([])
    end

    it 'bad query' do
      expect(TMDBInteraction.search_tmdb).to eq('No query term given')
    end
  end
end
