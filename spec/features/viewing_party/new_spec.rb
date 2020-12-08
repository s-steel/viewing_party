require 'rails_helper'

describe 'New viewing party' do
  describe 'visit new page' do
    before :each do
      @user = create(:user)
      @user2 = create(:user)
      @user.followed << @user2
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'good path' do
      VCR.use_cassette('viewing-party/new_spec_good') do
        visit viewing_party_new_path(movie_id: 400_160)

        expect(page).to have_content('The SpongeBob Movie')
        fill_in('viewing_party[date_time]', with: '01/01/2021 11:30')

        check(@user2.user_name)

        click_button('Create Party')

        party = Parties.last

        expect(party.movie_id).to eq(400_160)
        expect(party.duration).to eq(95)
        expect(party.start_date_time).to eq('Friday January 1st, 2021 at 11:30 AM')
      end
    end

    it 'bad date and time' do
      VCR.use_cassette('viewing-party/new_spec_bad_date_time') do
        visit viewing_party_new_path(movie_id: 400_160)

        expect(page).to have_content('The SpongeBob Movie')
        fill_in('viewing_party[date_time]', with: 'sdflkadsjflkjaf')

        click_button('Create Party')

        expect(page).to have_content('Please fill out all fields with proper information')
      end
    end

    it 'no date and time' do
      VCR.use_cassette('viewing-party/new_spec_no_date_time') do
        visit viewing_party_new_path(movie_id: 400_160)

        expect(page).to have_content('The SpongeBob Movie')

        click_button('Create Party')

        expect(page).to have_content('Please fill out all fields with proper information')
      end
    end
  end
end
