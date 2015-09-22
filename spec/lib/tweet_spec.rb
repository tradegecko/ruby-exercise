require 'rails_helper'

describe Tweet do

  let!(:client) { TwitterApi.new }
  let!(:tweet) { Tweet.new }

  describe ".initialize" do
    it "sets the twitter client" do
      expect(tweet.client).to_not be_nil
    end
  end

  describe  "#requests" do
    before :each do
      tweet.requests
    end
    it "receives save_mentions" do
      expect(client).to receive(:save_mentions)
      client.save_mentions
    end
    it "receives reply_unreplied_mentions" do
      expect(client).to receive(:reply_unreplied_mentions)
      client.reply_unreplied_mentions
    end
  end

  describe "#random_song" do
    before :each do
      tweet.random_song
    end
    it "receives followed_artist" do
      expect(client).to receive(:followed_artist)
      client.followed_artist
    end
    it "receives update" do
      expect(client).to receive(:update).with("hello")
      client.update("hello")
    end
  end


end
