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

  def self.movie_by_id(id)
    conn = Faraday.new('https://api.themoviedb.org/3/') do |req|
      req.params['api_key'] = ENV['TMDB_API_KEY']
    end

    data = conn.get("movie/#{id}")

    results = []
    results << JSON.parse(data.body, symbolize_names: true)

    create_movie_data(results).first
  end

  def self.movie_reviews(id)
    conn = Faraday.new('https://api.themoviedb.org/3/') do |req|
      req.params['api_key'] = ENV['TMDB_API_KEY']
    end

    data = conn.get("movie/#{id}/reviews")

    results = JSON.parse(data.body, symbolize_names: true)[:results]

    create_movie_data(results)
  end

  def self.movie_cast(id)
    conn = Faraday.new('https://api.themoviedb.org/3/') do |req|
      req.params['api_key'] = ENV['TMDB_API_KEY']
    end
#need to limit this to first 10 results
    data = conn.get("movie/#{id}/credits")

    results = JSON.parse(data.body, symbolize_names: true)[:cast]

    create_movie_data(results)
  end
end
