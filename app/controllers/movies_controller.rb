class MoviesController < ApplicationController
  before_action :authorize_user

  def show
    movie_details = MovieSearchFacade.movie_details(params[:id])
    @movie = movie_details[:movie]
    @cast = movie_details[:cast]
    @reviews = movie_details[:reviews]
  end

  def discover; end

  def index
    if params[:query].nil?
      @movies = MovieSearchFacade.top_movies
    elsif params[:query].empty?
      flash[:error] = 'Must enter a movie title as search query'
      redirect_to discover_path
    else
      @query = params[:query]
      @movies = MovieSearchFacade.search_tmdb(@query)
    end
  end

  private

  def authorize_user
    render file: 'public/404' unless current_user
  end
end
