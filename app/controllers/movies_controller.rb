class MoviesController < ApplicationController
  before_action :authorize_user

  def show
    @movie = TMDBInteraction.movie_by_id(params[:id])
  end

  def search
    @query = params[:query]
    @movies = TMDBInteraction.search_tmdb(@query)
  end


  private

  def authorize_user
    render file: 'public/404' unless current_user
  end
end
