require 'rails_helper'

describe 'Movies show page' do
  describe 'As an authenticated user, when I visit the movies detail page' do
    before(:each) { visit '/movies/343611' }

    it 'has a button to create a viewing party' do
      expect(page).to have_button('Create Viewing Party for this Movie')
      expect(current_path).to eq('/viewing-party/new')
    end
  end
end
