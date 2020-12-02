require 'faraday'
require 'json'
require_relative 'movie_data'

class TMDBInteraction
  # Returns an array of MovieData objects from TMDB related to the search term
  def self.search_tmdb(query)
    response = Faraday.get('https://api.themoviedb.org/3/search/movie') do |req|
      req.params['api_key'] = ENV['TMDB_API_KEY']
      req.params['query'] = query
    end

    structure = JSON.parse(response.body)

    structure['results'].map do |result|
      MovieData.new(result)
    end
  end
end
