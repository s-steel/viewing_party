require 'rails_helper'

RSpec.describe 'As an authenticated user' do
  describe "when I visit '/dashboard' I see" do
    before :each do
      @user = create(:user)
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
    end

    it 'a viewing party section with all parties I am invited to' do
      expect(page).to have_css('.parties', count: 1)
    end
    
  end
end