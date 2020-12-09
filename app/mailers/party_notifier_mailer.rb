class PartyNotifierMailer < ApplicationMailer

  def invite(info)
    @user = info[:user]
    @friend = info[:friend]
    @friend_email = info[:friend_email]
    @movie_title = info[:movie]
    @party_time = info[:party_time]

    mail(
      reply_to: @user.email, 
      to: @friend_email, 
      subject: "#{@user.user_name} has sent you a viewing party invitation"
    )
  end
end
