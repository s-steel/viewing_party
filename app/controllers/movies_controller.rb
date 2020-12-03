class MoviesController < ApplicationController
  before_action :authorize_user

  def search
    @query = params[:query]
    @movies = TMDBInteraction.search_tmdb(@query)
  end

  def discover 
    
  end

  private

  def authorize_user
    render file: 'public/404' unless current_user
  end
end
