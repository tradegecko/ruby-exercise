require 'rails_helper'

describe TweetComposer do

  include TweetComposer

  let!(:reply_tweet) do
    {
      reply_to: "iallenchun",
      track_name: "Sugar",
      artist_name: "Maroon 5",
      player: "spotify_url"
    }
  end

  let!(:hourly_tweet) do
    {
      track_name: "Cool Kids",
      artist_name: "Echosmith",
      player: "spotify_url"
    }
  end

  describe "composed_tweet" do
    context "reply_to is present" do
      it "tweets reply_tweet" do
        expect(composed_tweet(reply_tweet)).to eq "Hi @iallenchun here's \"Sugar\" by Maroon 5 listen now on spotify_url"
      end
    end

    context "reply_to is not present" do
      it "tweets a hourly_tweet" do
        expect(composed_tweet(hourly_tweet)).to eq "NP: \"Cool Kids\" by Echosmith listen now on spotify_url"
      end
    end
  end

end
