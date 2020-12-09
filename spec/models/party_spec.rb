require 'rails_helper'

describe Party, type: :model do
  describe 'validations' do
    it do
      should validate_presence_of :movie_id
      should validate_presence_of :duration
      should validate_presence_of :when
      should validate_presence_of :host_id
    end
  end

  describe 'relationships' do
    it do
      should belong_to :host
      should have_many :party_guests
      should have_many(:guests).through(:party_guests)
    end
  end

  describe 'instance methods' do
    it '.start_date_time' do
      user = create(:user)
      party = Party.create!(
        host: user,
        when: DateTime.new(2021, 0o1, 0o1, 11, 30),
        duration: 270,
        movie_id: 400_160
      )
      expect(party.start_date_time).to eq('Friday January 1, 2021 at 11:30 AM')
    end
  end
end
