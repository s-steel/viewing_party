class MoviesController < ApplicationController
  before_action :authorize_user

  def search
    #we can refactor this into index using an if @query
    @query = params[:query]
    if @query.empty? 
      flash[:error] = 'Must enter a movie title as search query'
      redirect_to discover_path
    else 
      @movies = TMDBInteraction.search_tmdb(@query)
    end
  end

  def discover 
    
  end

  def index
    @movies = TMDBInteraction.top_movies
  end

  private

  def authorize_user
    render file: 'public/404' unless current_user
  end
end
