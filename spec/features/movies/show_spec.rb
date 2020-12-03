require 'rails_helper'

describe 'Movies show page' do
  describe 'As an authenticated user, when I visit the movies detail page' do

    it 'has a button to create a viewing party' do
      visit '/movies/343611'
      expect(page).to have_button('Create Viewing Party for this Movie')
      expect(current_path).to eq('/viewing-party/new')
    end
  end
end
