require 'rails_helper'

RSpec.describe TweetData, type: :model do
  subject(:tweet_datum) { build :tweet_datum }

  it { is_expected.to be_valid }

  before do
    subject.save
  end

  describe "#word_hash" do
    it "should return markov chained hash of the whole TweetData" do
      chain = MarkovChain.new(text: subject.content, word_hash: {})
      expect(TweetData.word_hash).to eql chain.word_hash
    end
  end

  describe "#chain" do
    it "should return markov chain for the whole TweetData" do
      chain = MarkovChain.new(text: subject.content, word_hash: {})
      expect(TweetData.chain.word_hash).to eql chain.word_hash
    end
  end

  describe "#generate" do
    it "should generate content" do
      expect(TweetData.generate.length).to be <= 140
    end
  end

  describe "#create tweet" do
    it "should create Tweet" do
      expect{
        TweetData.generate_tweet
      }.to change(Tweet, :count).by 1
    end
  end
end
