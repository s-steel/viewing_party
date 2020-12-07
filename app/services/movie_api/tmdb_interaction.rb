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

  def self.api_connection
    Faraday.new('https://api.themoviedb.org/3/') do |req|
      req.params['api_key'] = ENV['TMDB_API_KEY']
    end
  end

  def self.parse_it(data)
    JSON.parse(data.body, symbolize_names: true)
  end

  def self.movie_by_id(id)
    data = api_connection.get("movie/#{id}")
    results = []
    results << parse_it(data)
    # Created an array here because this returns one object and the create_movie_data method requires an array

    create_movie_data(results).first
  end

  def self.movie_reviews(id)
    data = api_connection.get("movie/#{id}/reviews")

    results = parse_it(data)[:results]

    create_movie_data(results)
  end

  def self.movie_cast(id, limit = 100)
    data = api_connection.get("movie/#{id}/credits")

    results = parse_it(data)[:cast]
    limited_results = results.take(limit)
    # ^^ Not sure if we should be using `take` within this call or refactor it out into a model method to be call at another time
    create_movie_data(limited_results)
  end
end
