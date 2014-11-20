require 'spec_helper'
require 'pry'

RSpec.describe Ejaydj::Services::PlaylistService do

  let(:music_client) { double('MusicClient') }
  let(:playlist_service) do
    Ejaydj::Services::PlaylistService.new(music_client: music_client, user_id: 1)
  end

  describe '#all' do
    let(:response) do
      [{"id" => 1, "owner" => {"id" => 1}, "name" => 'Playlist 1', "external_urls" => '/playlist1', "tracks" => {"total" => 10}},
       {"id" => 2, "owner" => {"id" => 1}, "name" => 'Playlist 2', "external_urls" => '/playlist2', "tracks" => {"total" => 20}}]
    end

    before do
      allow(music_client).to receive(:user_playlists).and_return(response)
    end

    it "returns a list of Playlists" do
      playlists = playlist_service.all
      expect(playlists.first.class).to eq Ejaydj::Playlist
    end

    it "returns all playlists of the user" do
      playlists = playlist_service.all
      expect(playlists.count).to eq response.count
    end

  end
end
