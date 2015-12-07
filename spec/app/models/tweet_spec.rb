require 'rails_helper'

RSpec.describe Tweet, :type => :model do

  describe '#tweet_random_gif' do
    subject { Tweet }
    let(:keyword) { 'holla' }

    context 'success case - normal tweet of a found gif' do
      it 'Tweets random gif of the keyword' do
        VCR.use_cassette('app/model/tweets/a_proper_random_gif_tweeted') do
          expect { subject.tweet_random_gif(keyword) }.to change(Tweet, :count).by(1)
          tweet = Tweet.last
          expect(tweet.gif.keyword).to eq 'holla'
        end
      end
    end

    context 'Failure cases' do

      context 'no gifs found on the keyword' do
        let(:keyword) { 'ThereShouldBeNoWayThatThereIsAGifUnderThisName' }

        it 'raise an exception' do
          VCR.use_cassette('app/model/tweets/random_search_with_empty_result') do
            expect(STDOUT).to receive(:puts).with('Validation failed: Url No gif found on Giphy server')
            expect { subject.tweet_random_gif(keyword) }.not_to change(Tweet, :count)
          end
        end
      end

      context 'tweeting the same content' do
        it 'raise an exception on the second time' do
          VCR.use_cassette('app/model/tweets/tweeting_same_content') do
            # First tweet
            expect { subject.tweet_random_gif(keyword) }.to change(Tweet, :count).by(1)
            first_tweet = Tweet.last

            # Second tweet with same content
            allow_any_instance_of(GiphyApi).to receive(:fetch_random_gif).and_return(URI(first_tweet.gif.url))
            expect(STDOUT).to receive(:puts).with('Validation failed: Url Gif already tweeted')
            expect { subject.tweet_random_gif(keyword) }.not_to change(Tweet, :count)
          end
        end
      end
    end
  end

  describe '#tweet_random_words' do
    subject { Tweet.tweet_random_words('random_tweets') }

    it 'Tweets random words to twitter' do
      VCR.use_cassette('app/model/tweets/random_words') do
        expect { subject }.to change(Tweet, :count).by(2)
        expect(Tweet.last.text).to include '#random_tweets'
      end
    end
  end
end