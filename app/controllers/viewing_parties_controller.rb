class ViewingPartiesController < ApplicationController
  before_action :authorize_user

  def new
    @movie = MovieSearchFacade.movie_details(params[:movie_id])[:movie]
    @party = Party.new
    @user = current_user
  end

  def create
    @movie = MovieSearchFacade.movie_details(params[:party][:movie_id])[:movie]

    begin
      @party = Party.create!(party_data)

      params[:party][:guests].keys.each do |guest_id|
        @party.guests << User.find(guest_id)
      end
      flash[:success] = 'You created a new viewing party!'
      redirect_to dashboard_path
    rescue ActiveRecord::RecordInvalid
      flash.now[:error] = 'Please fill out all fields with proper information'
      @user = current_user
      render :new
    end
  end

  private

  def authorize_user
    render file: 'public/404' unless current_user
  end

  def party_data
    output = params.require(:party).permit(
      :when,
      :movie_id
    )
    output[:host] = current_user
    output[:duration] = if params[:party][:end_time].empty?
                          @movie.runtime
                        else
                          (DateTime.new(*params[:party][:end_time].split(/[^0-9]/).map(&:to_i)) - DateTime.new(*params[:party][:when].split(/[^0-9]/).map(&:to_i))) * 1440
                        end

    output
  end
end
