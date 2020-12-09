class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = 'You have successfully logged in!'
      redirect_to '/dashboard'
    else
      flash[:error] = 'Invalid email or password, please try again.'
      redirect_to root_path
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:success] = 'You are now logged out!'

    redirect_to root_path
  end
end
