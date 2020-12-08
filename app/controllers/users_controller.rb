class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      flash[:success] = 'You have successfully registered!'
      session[:user_id] = @user.id
      redirect_to dashboard_path
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      render :new
    end
  end

  def show
    @user = current_user
    @parties = @user.hosted_parties + @user.parties
    @movies = @parties.each_with_object({}) do |party, output|
      output[party] = MovieSearchFacade.movie_details(party.movie_id)
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
