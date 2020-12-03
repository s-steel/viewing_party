class MoviesController < ApplicationController
  before_action :authorize_user

  def search
    #we can refactor this into index using an if @query
    @query = params[:query]
    @movies = TMDBInteraction.search_tmdb(@query)
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
