require 'spec_helper'

RSpec.describe Ejaydj::Spotify::Client do

  let(:rest_client) { double('RestClient') }
  let(:spotify_client) do
    Ejaydj::Spotify::Client.new(rest_client:   rest_client,
                                client_id:     'client_1',
                                client_secret: 'client_secret_1')
  end

  before do
    allow(rest_client).to receive(:get).and_return(response)
    allow(rest_client).to receive(:post).with(
      "#{Ejaydj::Spotify::Client::ACCOUNT_API_URL}/api/token", anything(), anything())
        .and_return('{"access_token": "token_1"}')
  end

  describe '#user_playlists' do
    let(:response) do
      '{ "items": [
          {"name": "Playlist 1"},
          {"name": "Playlist 2"}
        ]
      }'
    end

    it "returns the given user playlists as an array of JSON" do
      response_items = spotify_client.user_playlists(user_id: 1)
      expect(response_items.first.class).to eq(Hash)
    end
  end

  describe '#playlist_tracks' do
    let(:response) do
      '{ "items": [
          {"name": "Track 1"},
          {"name": "Track 2"}
        ]
      }'
    end

    it "returns the the given playlist's tracks as an array of JSON" do
      response_items = spotify_client.playlist_tracks(user_id: 1, playlist_id: 1)
      expect(response_items.first.class).to eq(Hash)
    end
  end

end
