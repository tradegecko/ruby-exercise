require 'rails_helper'
require 'the_game_gal_api'

RSpec.describe TheGameGalApi do

  describe '#fetch_random_words' do
    subject { TheGameGalApi.fetch_random_words }

    it 'get random strings' do
      VCR.use_cassette('tasks/fetch_random_words') do
        expect(subject.count).to be 2
        expect(subject).to all( be_a(String))
      end
    end
  end
end