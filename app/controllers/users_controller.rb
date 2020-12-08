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
  end

  private 
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
