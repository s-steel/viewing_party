require 'rails_helper'

describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :password }
  end

  describe 'Instance Methods' do 
    before :each do
      @user = User.create!(email: 'me@email.com',
                           password: 'password')
    end

    it 'user_name' do
      expect(@user.user_name).to eq('me')
    end
  end
end