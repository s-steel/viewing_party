require 'faraday'
require 'json'

class TMDBInteraction
  # Returns an array of MovieData objects from TMDB related to the search term
  def self.search_tmdb(query)
    conn = create_connection('search/movie', query)
    results = get_40_results(conn)
    json_parse(results)
  end

  def self.top_movies
    conn = create_connection('movie/top_rated')
    results = get_40_results(conn)
    json_parse(results)
  end

  def self.movie_details(id)
    conn = create_connection("movie/#{id}", nil, 'reviews,credits,similar')
    result = conn.get('')
    json = json_parse(result)
  end

  def self.create_connection(api_call, query = nil, append = nil)
    Faraday.new("https://api.themoviedb.org/3/#{api_call}") do |req|
      req.params['api_key'] = ENV['TMDB_API_KEY']
      req.params['query'] = query if query
      req.params['append_to_response'] = append if append
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

  def self.json_parse(data)
    page1, page2 = data
    return JSON.parse(data.body, symbolize_names: true) if page2.nil?

    JSON.parse(page1.body, symbolize_names: true)[:results].concat(JSON.parse(page2.body, symbolize_names: true)[:results])
  end
end
