require 'rails_helper'
require './app/services/movie_api/movie_data'

describe MovieData do
  before :each do
    data = {
      'id' => 400_160,
      'backdrop_path' => '/wu1uilmhM4TdluKi2ytfz8gidHf.jpg',
      'genre_ids' => [
        16,
        14,
        12,
        35,
        10_751
      ],
      'original_language' => 'en',
      'original_title' => 'The SpongeBob Movie => Sponge on the Run',
      'poster_path' => '/jlJ8nDhMhCYJuzOw3f52CP1W8MW.jpg',
      'title' => 'The SpongeBob Movie => Sponge on the Run',
      'video' => false,
      'vote_average' => 8,
      'popularity' => 737.45,
      'overview' => 'When his best friend Gary is suddenly snatched away, SpongeBob takes Patrick on a madcap mission far beyond Bikini Bottom to save their pink-shelled pal.',
      'release_date' => '2020-08-14',
      'vote_count' => 1620,
      'adult' => false
    }

    @test_object = MovieData.new(data)
  end

  describe 'get attributes' do
    it 'title' do
      expect(@test_object.title).to eq('The SpongeBob Movie => Sponge on the Run')
    end

    it 'id' do
      expect(@test_object.id).to eq(400_160)
    end
  end
end

describe 'Instance Methods' do
  before :each do
    data = {
      'id' => 400_160,
      'backdrop_path' => '/wu1uilmhM4TdluKi2ytfz8gidHf.jpg',
      'genres' =>
        [{:id=>16, :name=>"Animation"},
          {:id=>14, :name=>"Fantasy"},
          {:id=>12, :name=>"Adventure"},
          {:id=>35, :name=>"Comedy"},
          {:id=>10751, :name=>"Family"}],
      'original_language' => 'en',
      'original_title' => 'The SpongeBob Movie => Sponge on the Run',
      'poster_path' => '/jlJ8nDhMhCYJuzOw3f52CP1W8MW.jpg',
      'title' => 'The SpongeBob Movie => Sponge on the Run',
      'video' => false,
      'vote_average' => 8,
      'popularity' => 737.45,
      'overview' => 'When his best friend Gary is suddenly snatched away, SpongeBob takes Patrick on a madcap mission far beyond Bikini Bottom to save their pink-shelled pal.',
      'release_date' => '2020-08-14',
      'vote_count' => 1620,
      'adult' => false
    }

    @test_object = MovieData.new(data)
  end

  it 'movie_genres' do
    expect(@test_object.all_genres).to eq('Animation, Fantasy, Adventure, Comedy, Family')
  end
end
