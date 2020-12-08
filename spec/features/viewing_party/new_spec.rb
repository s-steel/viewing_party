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
        fill_in('party[when]', with: '2021-01-01T11:30')

        check("party[guests[#{@user2.id}]]")

        click_button('Create Party')

        party = Party.last

        expect(party.movie_id).to eq(400_160)
        expect(party.duration).to eq(95)
        expect(party.start_date_time).to eq('Friday January 1, 2021 at 11:30 AM')
        expect(party.guests[0]).to eq(@user2)
      end
    end

    it 'good path with custom duration' do
      VCR.use_cassette('viewing-party/new_spec_good') do
        visit viewing_party_new_path(movie_id: 400_160)

        expect(page).to have_content('The SpongeBob Movie')
        fill_in('party[when]', with: '2021-01-01T11:30')
        fill_in('party[end_time]', with: '2021-01-01T16:00')

        check("party[guests[#{@user2.id}]]")

        click_button('Create Party')

        party = Party.last

        expect(party.movie_id).to eq(400_160)
        expect(party.duration).to eq(270)
        expect(party.start_date_time).to eq('Friday January 1, 2021 at 11:30 AM')
        expect(party.guests[0]).to eq(@user2)

      end
    end

    it 'bad date and time' do
      VCR.use_cassette('viewing-party/new_spec_bad_date_time') do
        visit viewing_party_new_path(movie_id: 400_160)

        expect(page).to have_content('The SpongeBob Movie')
        fill_in('party[when]', with: 'sdflkadsjflkjaf')

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

    xit 'after clicking Create Party it redirects to the dashboard' do
      VCR.use_cassette('viewing-party/new_spec_good') do
        visit viewing_party_new_path(movie_id: 400_160)

        fill_in('party[when]', with: '2021-01-01T11:30')

        check("party[guests[#{@user2.id}]]")

        click_button('Create Party')

        expect(current_path).to eq(dashboard_path)
        expect(page).to have_content('You created a new viewing party')
        # expect(page).to have_content
      end
    end
  end
end
