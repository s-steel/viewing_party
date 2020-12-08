class MovieSearchFacade 

  def self.top_movies
    json_response = TMDBInteraction.top_movies
    create_movie_data(json_response)
  end

  def self.search_tmdb(query)
    json_response = TMDBInteraction.search_tmdb(query)
    create_movie_data(json_response)
  end

  def self.movie_details(movie_id)
    json_response = TMDBInteraction.movie_details(movie_id)
    MovieData.new(json_response)
  end

  private 
    def self.create_movie_data(movies)
      movies.map do |movie| 
        MovieData.new(movie)
      end 
    end

end