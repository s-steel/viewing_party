class SessionsController < ApplicationController
  def new
    flash[:success] = 'You are already logged in!' if current_user

    redirect_to '/dashboard'
  end

  def create
    if user = User.find_by(email: params[:email])
      session[:user_id] = user.id
      flash[:success] = "You have successfully logged in!"
      redirect_to '/dashboard'
    else
      flash[:error] = 'Invalid email or password, please try again.'
      redirect_to root_path
    end
  end
end