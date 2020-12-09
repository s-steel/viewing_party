require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many :followers_ref }
    it { should have_many(:followed).through(:followers_ref) }
    it { should have_many :followed_ref }
    it { should have_many(:followers).through(:followed_ref) }
    it { should have_many(:party_guests)}
    it { should have_many(:parties).through(:party_guests)}
    it { should have_many :hosted_parties }
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

    describe 'user_exist?(user)' do
      before :each do
        @user = create(:user)
        @user_2 = build(:user)
      end

      it 'returns true if a user exists in the system with user_name' do
        expect(User.find_user(@user.user_name)).to eq(@user)
      end

      it 'returns true if a user exists in the system with user.email' do
        expect(User.find_user(@user.email)).to eq(@user)
      end

      it 'returns true if a user exists in the system with user_name upcased' do
        expect(User.find_user(@user.user_name.upcase)).to eq(@user)
      end

      it 'returns true if a user exists in the system with user.email upcased' do
        expect(User.find_user(@user.email.upcase)).to eq(@user)
      end

      it 'returns false if a user does not exist in the system with user_name' do
        expect(User.find_user(@user_2.user_name)).to eq(nil)
      end

      it 'returns false if a user does not exist in the system with user.email' do
        expect(User.find_user(@user_2.email)).to eq(nil)
      end
    end

    describe 'status' do
      before :each do
        @user = create(:user, :with_friends)
        @friend1 = @user.followed[0]
        @party1 = Party.create!(movie_id: 400_160, duration: 118, host_id: @user.id, when: '2021-01-01T11:30')
        @party1.guests << [@friend1]
      end

      it 'shows a host' do
        expect(@user.status(@party1)).to eq('Host')
      end

      it 'shows invited' do
        expect(@friend1.status(@party1)).to eq('Invited')
      end
    end
  end
end
