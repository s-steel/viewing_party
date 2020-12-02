require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:email)}
    it {should validate_uniqueness_of(:email)}
    it {should validate_presence_of(:password)}
  end

  describe 'instance methods' do
    describe 'user_name' do
      it 'returns the first half of the user\'s email address' do
        user = build(:user, email: 'jacobwest@example.com')
        expect(user.user_name).to eq('jacobwest')
      end
    end
  end
end