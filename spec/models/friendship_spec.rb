require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'relationships' do
    # it { should belong_to :follower }
    # it { should belong_to :followed }

    # ^^ maybe don't need this? Because you're testing the relationship through Users?
  end
end