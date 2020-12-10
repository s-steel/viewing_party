require 'rails_helper'
# require 'spec/fixtures/poros_fixtures/details.json'

describe MovieData do
  before :each do
    @example = {
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
    @test_object = MovieData.new(@example)
  end

  describe 'get attributes from search/top_rated call' do
    it 'title' do
      expect(@test_object.title).to eq(@example['original_title'])
    end

    it 'id' do
      expect(@test_object.id).to eq(@example['id'])
    end
  end
end

describe 'Instance Methods' do
  before :each do
    data = {
      'id' => 400_160,
      'backdrop_path' => '/wu1uilmhM4TdluKi2ytfz8gidHf.jpg',
      'genres' =>
        [{ id: 16, name: 'Animation' },
         { id: 14, name: 'Fantasy' },
         { id: 12, name: 'Adventure' },
         { id: 35, name: 'Comedy' },
         { id: 10_751, name: 'Family' }],
      'original_language' => 'en',
      'original_title' => 'The SpongeBob Movie => Sponge on the Run',
      'poster_path' => '/jlJ8nDhMhCYJuzOw3f52CP1W8MW.jpg',
      'title' => 'The SpongeBob Movie => Sponge on the Run',
      'video' => false,
      'vote_average' => 8,
      'runtime' => 95,
      'popularity' => 737.45,
      'overview' => 'When his best friend Gary is suddenly snatched away, SpongeBob takes Patrick on a madcap mission far beyond Bikini Bottom to save their pink-shelled pal.',
      'release_date' => '2020-08-14',
      'vote_count' => 1620,
      'adult' => false
    }
    @test_object = MovieData.new(data)
  end

  describe 'instance methods with movie_by_id_search' do
    it 'movie_genres' do
      expect(@test_object.all_genres).to eq('Animation, Fantasy, Adventure, Comedy, Family')
    end

    it 'format_run_time' do
      expect(@test_object.format_run_time).to eq('1 hr 35 min')
    end

    it 'image_source' do
      detail = {
        'adult' => false,
        'backdrop_path' => '/wu1uilmhM4TdluKi2ytfz8gidHf.jpg',
        'belongs_to_collection' => {
          'id' => 275_402,
          'name' => 'SpongeBob Collection',
          'poster_path' => '/bsCBgNIeqwUh0rWrEjojH7Xbqto.jpg',
          'backdrop_path' => '/uDbMvHRX0LMUxmsMyOOrPeLYHO5.jpg'
        },
        'budget' => 60_000_000,
        'genres' => [
          {
            'id' => 16,
            'name' => 'Animation'
          },
          {
            'id' => 14,
            'name' => 'Fantasy'
          },
          {
            'id' => 12,
            'name' => 'Adventure'
          },
          {
            'id' => 35,
            'name' => 'Comedy'
          },
          {
            'id' => 10_751,
            'name' => 'Family'
          }
        ],
        'homepage' => 'https://www.spongebobmovie.com/',
        'id' => 400_160,
        'imdb_id' => 'tt4823776',
        'original_language' => 'en',
        'original_title' => 'The SpongeBob Movie: Sponge on the Run',
        'overview' => 'When his best friend Gary is suddenly snatched away, SpongeBob takes Patrick on a madcap mission far beyond Bikini Bottom to save their pink-shelled pal.',
        'popularity' => 637.303,
        'poster_path' => '/jlJ8nDhMhCYJuzOw3f52CP1W8MW.jpg',
        'production_companies' => [
          {
            'id' => 8921,

            'name' => 'United Plankton Pictures',
            'origin_country' => 'US'
          },
          {
            'id' => 2348,
            'logo_path' => '/m31fQvZJuUvAgxoqTiCGYFBfZYe.png',
            'name' => 'Nickelodeon Movies',
            'origin_country' => 'US'
          },
          {
            'id' => 24_955,
            'logo_path' => '/bX3cYCRWdddXTgIcDEfNiVa8U4j.png',
            'name' => 'Paramount Animation',
            'origin_country' => 'US'
          },
          {
            'id' => 4,
            'logo_path' => '/fycMZt242LVjagMByZOLUGbCvv3.png',
            'name' => 'Paramount',
            'origin_country' => 'US'
          },
          {
            'id' => 2531,
            'logo_path' => '/pC2iDCDCvV85vOBP7a5Ukxuc0Du.png',
            'name' => 'MRC',
            'origin_country' => 'US'
          },
          {
            'id' => 8649,

            'name' => 'Mikros Image',
            'origin_country' => 'FR'
          }
        ],
        'production_countries' => [
          {
            'iso_3166_1' => 'KR',
            'name' => 'South Korea'
          },
          {
            'iso_3166_1' => 'US',
            'name' => 'United States of America'
          }
        ],
        'release_date' => '2020-08-14',
        'revenue' => 4_700_000,
        'runtime' => 95,
        'spoken_languages' => [
          {
            'english_name' => 'English',
            'iso_639_1' => 'en',
            'name' => 'English'
          }
        ],
        'status' => 'Released',
        'tagline' => "They're Not in Bikini Bottom Anymore.",
        'title' => 'The SpongeBob Movie: Sponge on the Run',
        'video' => false,
        'vote_average' => 8.0,
        'vote_count' => 1678
      }

      @full_detail = MovieData.new(detail)

      expect(@full_detail.image_source).to eq("https://image.tmdb.org/t/p/original/jlJ8nDhMhCYJuzOw3f52CP1W8MW.jpg?api_key=#{ENV['TMDB_API_KEY']}")
    end
  end
end
