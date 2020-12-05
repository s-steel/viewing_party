require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many :followers }
    it { should have_many(:followed).through(:followers) }
    # why does above ^ error but below passes???
    # it { should have_many(:followed).class_name('Friendship').with_foreign_key('followed_id') }
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
