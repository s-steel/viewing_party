class MovieSearchFacade
  def self.top_movies
    json_response = TMDBInteraction.top_movies
    create_movie_data(json_response)
  end

  def self.search_tmdb(query)
    json_response = TMDBInteraction.search_tmdb(query)
    create_movie_data(json_response)
  end

  def self.movie_details(movie_id, similar_limit = 100)
    json_response = TMDBInteraction.movie_details(movie_id)
    movie = MovieData.new(json_response.except(:reviews, :credits, :similar))
    actors = create_actors(json_response[:credits][:cast]).first(10)
    reviews = create_reviews(json_response[:reviews][:results])
    similar_movies = create_movie_data(json_response[:similar][:results]).take(similar_limit)
    { movie: movie, cast: actors, reviews: reviews, similar_movies: similar_movies }
  end

  private

  def self.create_movie_data(movies)
    movies.map do |movie|
      MovieData.new(movie)
    end
  end

  def self.create_actors(actors)
    actors.map do |actor|
      Actor.new(actor)
    end
  end

  def self.create_reviews(reviews)
    reviews.map do |review|
      Review.new(review)
    end
  end
end
