require 'rails_helper'

RSpec.describe PartyNotifierMailer, type: :mailer do 
  describe 'invite' do
    before :each do
      @party_host = create(:user)
      @guest = create(:user)
      @event
      @email_info = {
        user: @party_host, 
        friend: @guest.user_name,
        friend_email: @guest.email, 
        movie: 'The Lord of the Rings', 
        party_time: 'Friday, 13th 6:00 pm'
      }
      @message = "#{@party_host.user_name} has sent you a viewing party invitation for #{@email_info[:movie]} on #{@email_info[:party_time]}."
      @mail = PartyNotifierMailer.invite(@email_info) 
    end
    
    it 'renders the headers' do
      expect(@mail.subject).to eq("#{@party_host.user_name} has sent you a viewing party invitation")
      expect(@mail.to).to eq(["#{@guest.email}"])
      expect(@mail.from).to eq(['no-reply@turing.io'])
      expect(@mail.reply_to).to eq(["#{@party_host.email}"])
    end

    it 'render the message body' do
      expect(@mail.text_part.body.to_s).to include("Hello #{@guest.user_name}")
      expect(@mail.text_part.body.to_s).to include(@message)
      expect(@mail.html_part.body.to_s).to include("Hello #{@guest.user_name}")
      expect(@mail.html_part.body.to_s).to include(@message)
    end
  end
end
