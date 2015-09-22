require 'rails_helper'

describe TwitterApi do

  let!(:api) { TwitterApi.new }

  describe ".initialize" do
    it "sets the client" do
      expect(api.client).to_not be_nil
    end
  end

  describe "#update" do
    it "calls update from api" do
      expect(api).to receive(:update).with("hello")
      api.update("hello")
    end
  end

  describe "#followed_artist" do
    it "calls followed_atrtists" do
      expect(api).to receive(:followed_artist)
      api.followed_artist
    end
  end

  describe "#save_mentions" do
    it "calls mentions_timeline" do
      expect(api).to receive(:save_mentions)
      api.save_mentions
    end
  end

  describe "#reply_unreplied_mentions" do
    before :each do
      allow(api).to receive(:reply_unreplied_mentions)
    end
    it "calls reply_unreplied_mentions" do
      expect(api).to receive(:reply_unreplied_mentions)
      api.reply_unreplied_mentions
    end
    it "returns nil" do
      expect(api.reply_unreplied_mentions).to be_nil
    end
  end

end
