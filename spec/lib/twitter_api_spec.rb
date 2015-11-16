require 'rails_helper'

RSpec.describe TwitterApi do

  describe '#fetch_tweets' do
    subject { TwitterApi.new }

    context 'Some tweets found by the keyword' do
      it 'should return an Array of Twitter::Tweet' do
        tweets = subject.fetch_tweets('a_giphy_bot')

        expect(tweets).to be_a Array
        expect(tweets.first).to be_a Twitter::Tweet
      end
    end

    context 'No tweets found by the keyword' do
      it 'should return an empty Array' do
        tweets = subject.fetch_tweets('@SomethingReallyRandomSoThatThereWillBeNoTweetFound')

        expect(tweets).to be_a Array
        expect(tweets).to be_empty
      end
    end
  end
end