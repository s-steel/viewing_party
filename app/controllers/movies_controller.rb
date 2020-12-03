class MoviesController < ApplicationController
  before_action :authorize_user

  def show
    @movie = TMDBInteraction.search_tmdb(params[:id])
    require 'pry', binding.pry
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
