require 'spec_helper'

RSpec.describe Ejaydj::Services::TrackService do

  let(:music_client) { double('MusicClient') }
  let(:track_service) do
    Ejaydj::Services::TrackService.new(music_client: music_client, user_id: 1, playlist_id: 1)
  end

  describe '#all' do
    let(:response) do
      [{"track" => {"id"            => 1,
                    "name"          => "Track 1",
                    "album"         => {"name" => "Album 1"},
                    "artists"       => [{"name" => "Artist 1"}],
                    "playlist_id"   => 1
                   }},

       {"track" => {"id"            => 2,
                    "name"          => "Track 2",
                    "album"         => {"name" => "Album 2"},
                    "artists"       => [{"name" => "Artist 2"}],
                    "playlist_id"   => 2
                   }}
      ]
    end

    before do
      allow(music_client).to receive(:playlist_tracks).and_return(response)
    end

    it "returns a list of Tracks" do
      tracks = track_service.all
      expect(tracks.first.class).to eq Ejaydj::Track
    end

    it "returns all the tracks of the playlist" do
      tracks = track_service.all
      expect(tracks.count).to eq response.count
    end

  end

end
