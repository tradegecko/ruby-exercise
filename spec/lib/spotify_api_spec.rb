require 'rails_helper'

describe SpotifyApi do

  let!(:spotify_client) { SpotifyApi.new "Maroon 5" }
  let!(:unknown_artist) { SpotifyApi.new "aaaaaaa" }

  describe ".initialize" do

    it "sets the artist" do
      expect(spotify_client.artist).to_not be_nil
    end

    context "artist is not nil" do
      it "receives top_tracks from us" do
        expect(spotify_client.artist).to receive(:top_tracks).with(:us)
        spotify_client.artist.top_tracks(:us)
      end
      it "sets the track" do
        expect(spotify_client.track).to_not be_nil
      end
    end

    context "artist is nil" do
      it "sets track to nil" do
        expect(unknown_artist.track).to eq nil
      end
    end

    context "track is not nil" do
      it "sets the player" do
        expect(spotify_client.player).to_not be_nil
      end
    end

    context "track is nil" do
      it "sets player to nil" do
        expect(unknown_artist.player).to eq nil
      end
    end

  end

end

