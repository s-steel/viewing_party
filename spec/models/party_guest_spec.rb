require 'rails_helper'

describe PartyGuest, type: :model do
  describe 'validations' do
    it do
      should validate_presence_of :party_id
      should validate_presence_of :user_id
    end
  end

  describe 'relationships' do
    it do
      should belong_to :party
      should belong_to :user
    end
  end
end
