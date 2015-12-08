require 'rails_helper'
require 'twitter_streaming_api'

RSpec.describe TwitterStreamingApi do
  subject { TwitterStreamingApi.new }

  describe '#stream' do
    it 'should get real time tweets' do
      allow_any_instance_of(Twitter::Streaming::Client).to receive(:filter).with(track: '6th day brewery').and_yield(
          Twitter::Tweet.new(id: 1, text: '#TheBestBreweryInSG')
        )
      subject.stream('6th day brewery') do |tweet|
        expect(tweet.text).to eq '#TheBestBreweryInSG'
      end

    end
  end
end