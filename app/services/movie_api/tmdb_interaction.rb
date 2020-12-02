require 'faraday'
require 'json'
require_relative 'movie_data'

class TMDBInteraction
  # Returns an array of MovieData objects from TMDB related to the search term
  def self.search_tmdb(query)
    conn = Faraday.new('https://api.themoviedb.org/3/search/movie') do |req|
      req.params['api_key'] = ENV['TMDB_API_KEY']
      req.params['query'] = query
    end

    page1 = conn.get do |req|
      req.params['page'] = 1
    end

    page2 = conn.get do |req|
      req.params['page'] = 2
    end

    results = JSON.parse(page1.body['results']).concat(JSON.parse(page2.body['results']))

    results.map do |result|
      MovieData.new(result)
    end
  end
end
