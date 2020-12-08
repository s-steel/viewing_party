require 'rails_helper'

RSpec.describe Actor do
  describe 'Instantiated object' do
    it 'returns attributes' do
      actor = {
        'adult' => false,
        'gender' => 2,
        'id' => 70_615,
        'known_for_department' => 'Acting',
        'name' => 'Rodger Bumpass',
        'original_name' => 'Rodger Bumpass',
        'popularity' => 5.025,
        'profile_path' => '/9TEh5QJAHnXuM3fE1Uu40QzXJQC.jpg',
        'cast_id' => 10,
        'character' => 'Squidward Tentacles (voice)',
        'credit_id' => '58459f4dc3a36844df01944a',
        'order' => 2
      }
      result = Actor.new(actor)

      expect(result.name).to eq(actor['name'])
      expect(result.character).to eq(actor['character'])
    end
  end
end
