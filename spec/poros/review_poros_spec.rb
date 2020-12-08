require 'rails_helper'

RSpec.describe Review do
  describe 'Instantiated object' do
    it 'returns attributes' do
      review = {
        'author' => 'SWITCH.',
        'author_details' => {
          'name' => 'SWITCH.',
          'username' => 'maketheSWITCH',
          'avatar_path' => '/klZ9hebmc8biG1RC4WmzNFnciJN.jpg',
          'rating' => 6.0
        },
        'content' => "Thanks to its meme resurgence, a surprisingly successful musical, three spinoff shows in the works and the thirteenth season currently airing, there is no slowing down Bikini Bottom's finest. As a fan, it was nice to spend some time with these characters who I haven't seen in a while - but the original movie and first few seasons are still superior in every way.\r\n- Chris dos Santos\r\n\r\nRead Chris' full article...\r\nhttps://www.maketheswitch.com.au/article/review-the-spongebob-movie-sponge-on-the-run-ravioli-ravioli-spongebobs-third-feature-is-okie-dokie",
        'created_at' => '2020-11-07T06:23:33.726Z',
        'id' => '5fa63d658c7b0f003f785d60',
        'updated_at' => '2020-11-10T17:11:45.490Z',
        'url' => 'https://www.themoviedb.org/review/5fa63d658c7b0f003f785d60'
      }
      result = Review.new(review)
      expect(result.author).to eq(review['author'])
      expect(result.content).to eq(review['content'])
    end
  end
end
