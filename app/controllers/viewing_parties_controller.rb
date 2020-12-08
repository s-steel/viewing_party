class ViewingPartiesController < ApplicationController
  before_action :authorize_user

  def new
    @movie = TMDBInteraction.movie_by_id(params[:movie_id])
    @party = ViewingPartyModel.new()
    @user = current_user
  end

  def create

  end

  private

  def authorize_user
    render file: 'public/404' unless current_user
  end
end
