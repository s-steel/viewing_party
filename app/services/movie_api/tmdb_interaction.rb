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

    parse_and_instantiate(conn)
  end

  def self.top_movies 
    conn = Faraday.new('https://api.themoviedb.org/3/movie/top_rated') do |req|
      req.params['api_key'] = ENV['TMDB_API_KEY']
    end

    parse_and_instantiate(conn)
  end

  def self.parse_and_instantiate(conn)
    page1, page2 = get_40_results(conn)

    results = JSON.parse(page1.body, symbolize_names: true)[:results].concat(JSON.parse(page2.body, symbolize_names: true)[:results])

    create_movie_data(results)
  end

  def self.create_movie_data(results)
    results.map do |result|
      MovieData.new(result)
    end
  end

  def self.get_40_results(conn)
    page1 = conn.get do |req|
      req.params['page'] = 1
    end

    page2 = conn.get do |req|
      req.params['page'] = 2
    end

    [page1, page2]
  end
end
