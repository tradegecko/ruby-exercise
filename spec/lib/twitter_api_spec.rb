require 'rails_helper'

RSpec.describe TwitterApi do
  subject { TwitterApi.new }

  describe '#fetch_tweets' do
    context 'Some tweets found by the keyword' do
      it 'should return an Array of Twitter::Tweet' do
        VCR.use_cassette('twitter/fetch_tweets_with_results') do
          tweets = subject.fetch_tweets('a_giphy_bot')

          expect(tweets).to be_a Array
          expect(tweets.first).to be_a Twitter::Tweet
        end
      end
    end

    context 'No tweets found by the keyword' do
      it 'should return an empty Array' do
        VCR.use_cassette('twitter/fetch_tweets_empty_results') do
          tweets = subject.fetch_tweets('@SomethingReallyRandomSoThatThereWillBeNoTweetFound')

          expect(tweets).to be_a Array
          expect(tweets).to be_empty
        end
      end
    end
  end

  describe '#tweet' do
    context 'with proper message' do
      it 'should post the tweet and returns the posted tweet' do
        VCR.use_cassette('twitter/tweet_a_proper_message') do
          tweet = subject.tweet('Hola! Everyone')

          expect(tweet).to be_a Twitter::Tweet
        end
      end
    end

    context 'with empty message' do
      it 'should raise an Argument Error' do
        expect{ subject.tweet('') }.to raise_error(ArgumentError, "Message can't be empty")
      end
    end

    context 'with long message' do
      it 'should raise an Argument Error' do
        message = 'AReallyLongMessageToBreakTheDefaultMessageLengthOfTwitter' * 3
        expect{ subject.tweet(message) }.to raise_error(ArgumentError, 'Message more than 140 characters')
      end
    end
  end
end