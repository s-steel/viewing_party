require 'rails_helper'

describe 'Movies show page' do
  describe 'As an authenticated user, when I visit the movies detail page' do
    before :each do
      @user = User.new(email: 'me@email.com',
        password: 'password')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit '/movies/400160'
    end

    it 'has a button to create a viewing party' do
      click_button('Create Viewing Party for this Movie')
      expect(current_path).to eq('/viewing-party/new')
    end
  end
end
