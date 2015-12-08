require 'rails_helper'
require 'twitter_rest_api'

RSpec.describe TwitterRestApi do
  subject { TwitterRestApi.new }

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
    let(:gif) { nil }
    let(:tweet) { build(:tweet, text: tweet_message, gif: gif) }

    context 'with proper message' do
      let(:tweet_message) { 'Hola! Everyone' }
      it 'should post the tweet and returns the posted tweet' do
        VCR.use_cassette('twitter/tweet_a_proper_message') do
          expect(subject.tweet(tweet)).to be_a Twitter::Tweet
        end
      end
    end

    context 'with empty message' do
      let(:tweet_message) { '' }
      it 'should raise an Argument Error' do
        expect { subject.tweet(tweet) }.to raise_error(ArgumentError, "Message and file both can't be empty")
      end
    end

    context 'with long message' do
      let(:tweet_message) { 'AReallyLongMessageToBreakTheDefaultMessageLengthOfTwitter' * 3 }
      it 'should raise an Argument Error' do
        expect { subject.tweet(tweet) }.to raise_error(ArgumentError, 'Message more than 140 characters')
      end
    end

    context 'tweeting with a file' do
      let(:tweet_message) { '' }
      let(:gif) { build(:gif) }
      it 'should post the tweet and returns the posted tweet' do
        VCR.use_cassette('twitter/tweet_a_file') do
          expect(gif).to receive(:file).and_return(File.new('spec/support/test'))
          expect(subject.tweet(tweet)).to be_a Twitter::Tweet
        end
      end
    end
  end
end