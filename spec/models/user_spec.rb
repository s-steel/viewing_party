require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many :followers_ref }
    it { should have_many(:followed).through(:followers_ref) }
    it { should have_many :followed_ref }
    it { should have_many(:followers).through(:followed_ref) }
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:password_confirmation) }
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
