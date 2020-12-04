class MoviesController < ApplicationController
  before_action :authorize_user

  def discover 
    
  end

  def index
    if params[:query].nil? 
      @movies = TMDBInteraction.top_movies
    elsif params[:query].empty? 
      flash[:error] = 'Must enter a movie title as search query'
      redirect_to discover_path
    else 
      @query = params[:query]
      @movies = TMDBInteraction.search_tmdb(@query)
    end 
  end

  private

  def authorize_user
    render file: 'public/404' unless current_user
  end
end
