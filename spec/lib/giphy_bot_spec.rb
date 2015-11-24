require 'rails_helper'

RSpec.describe GiphyBot do

  describe '#tweet_random_gif' do
    subject { GiphyBot.tweet_random_gif('holla') }

    it 'gets a random gif and tweets it and also saves into DB.' do
      VCR.use_cassette('tasks/a_proper_random_gif_tweeted') do
        expect(Rails.logger).to receive(:info).with('Starting tweet random gif task...')
        expect(Rails.logger).to receive(:info).with('Finished tweeting a random gif.')
        expect { subject }.to change(Tweet, :count).by(1)
      end
    end
  end
end