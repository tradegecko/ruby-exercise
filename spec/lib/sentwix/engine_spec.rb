require 'rails_helper'

describe Sentwix::Engine, :vcr do

  subject { Sentwix::Engine }
  let(:movie) { FactoryGirl.create(:movie, title: "Rurouni Kenshin: Kyoto Inferno") }

  describe '.fetch_tweets' do
    it 'returns an array of tweets given a movie activerecord object' do
      expect(subject.fetch_tweets(movie)).to be_a Array
    end

    it 'contains ::Tweet in array' do
      expect(subject.fetch_tweets(movie)).to include ::Tweet
    end

    it 'does not persist tweets' do
      tweets = subject.fetch_tweets(movie)
      expect(Tweet.all.count).to eq 0
    end

    it 'has a size of TWEETS_SEARCH_LIMIT' do
     expect(subject.fetch_tweets(movie).count).to eq subject::TWEETS_SEARCH_LIMIT
    end
  end

  describe '.store_tweets' do
    it 'takes an array of ::Tweets and stores in DB' do
      tweets = []
      5.times { tweets << FactoryGirl.build(:tweet) }
      expect{ subject.store_tweets(tweets) }.to change{ Tweet.count }.by 5
    end
  end

end
