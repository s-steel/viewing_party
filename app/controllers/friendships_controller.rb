class FriendshipsController < ApplicationController
  def create
    if User.find_user(friend_params) && !friend_self?(friend_params)
      current_user.followed << User.find_user(friend_params)
    elsif User.find_user(friend_params) && !friend_params.empty?
      flash[:error] = 'You cannot add yourself as a friend'
    elsif !friend_params.empty?
      flash[:error] = 'That user doesn\'t exist in the system'
    end
    redirect_to dashboard_path
  end

  private

  def friend_self?(friend)
    current_user.email.include?(friend)
  end

  def friend_params
    params.permit(:friend_search)[:friend_search]
  end
end
