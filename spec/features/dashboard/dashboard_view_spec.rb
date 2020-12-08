require 'rails_helper'

RSpec.describe 'As an authenticated user' do
  describe "when I visit '/dashboard' I see" do
    before :each do
      @user = create(:user)
      @user2 = create(:user)
      @user3 = create(:user)
      @user4 = create(:user)
      @user.followed << [@user2, @user3, @user4]
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit dashboard_path
    end

    it 'a welcome message with my name at the top of the page' do
      expect(page).to have_content("Welcome #{@user.user_name}")
    end

    it 'a button to discover movies' do
      within '.discover' do
        expect(page).to have_button('Discover Movies')
      end
    end

    it 'a friends section with my listed friends' do
      expect(page).to have_css('.friends', count: 1)
      expect(page).to have_css('.friend-list')
      within('.friend-list') do
        expect(page).to have_content(@user2.user_name)
        expect(page).to have_content(@user3.user_name)
        expect(page).to have_content(@user4.user_name)
      end
    end

    it 'a viewing party section with all parties I am invited to' do
      expect(page).to have_css('.parties', count: 1)
    end

    describe 'when I click on the Discover Movies button' do
      it 'I am taken to the discover page' do
        within '.discover' do
          click_button('Discover Movies')
          expect(current_path).to eq(discover_path)
        end
      end
    end

    describe 'I see all my viewing party details' do
      before :each do
        @party1 = Party.create!(movie_id: 343_611, duration: 118, host_id: @user.id, when: '2021-01-01T11:30')
        @party1.guests << [@user3, @user4]
      end
      context 'viewing parties I have been invited to' do
        it 'shows the movie title, date and time of event, and staus of Invited'
        # Movie Title
        # Date and Time of Event
        # Status of Invited
      end

      context 'viewing parties that I have created' do
        it 'shows the movie title, date and time of event, and staus of Host' do
          within('.parties') do
            expect(page).to have_content(@party1)
          end
        # Movie Title
        # Date and Time of Event
        # Status of Host
        end
      end
    end
  end
end
