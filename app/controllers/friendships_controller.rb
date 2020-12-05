class FriendshipsController < ApplicationController
  
  def create 
    require 'pry'; binding.pry
    redirect_to dashboard_path
  end


  private 

  def friend_params
    params.permit(:friend_search)
  end
  
end