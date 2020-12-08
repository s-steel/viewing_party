require 'rails_helper'

describe 'New viewing party' do
  describe 'visit new page' do
    before :each do
      @user = create(:user)
      @user2 = create(:user)
      # @user.followed << @user2
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'without followers without dashboard view' do
      visit viewing_party_new_path(movie_id: 400_160)

      expect(page).to have_content('The SpongeBob Movie')
      fill_in('viewing_party[date]', with: '01/01/2021')
      fill_in('viewing_party[time]', with: '11:30')

      click_button('Create Party')

      party = Parties.last

      expect(party.movie_id).to eq(400_160)
      expect(party.duration).to eq(95)
      expect(party.start_date_time).to eq('Friday January 1st, 2021 at 11:30 AM')
    end

    it 'bad date and time' do
      visit viewing_party_new_path(movie_id: 400_160)

      expect(page).to have_content('The SpongeBob Movie')
      fill_in('viewing_party[date]', with: 'fsdafasdf')
      fill_in('viewing_party[time]', with: 'asdfadfs')

      click_button('Create Party')

      expect(page).to have_content('Please fill out all fields with proper information')
    end

    it 'no date and time' do
      visit viewing_party_new_path(movie_id: 400_160)

      expect(page).to have_content('The SpongeBob Movie')

      click_button('Create Party')

      expect(page).to have_content('Please fill out all fields with proper information')
    end
  end
end
