require 'spec_helper'

RSpec.describe Ejaydj::Playlist do

  let(:music_client) { double('MusicClient') }
  let(:playlist) do
    Ejaydj::Playlist.new(
      name: 'Playlist 1',
      music_client: music_client)
  end

  let(:track_items) do
    [
      {"track" => { "id"            => 1,
                    "name"          => "Track 1",
                    "album"         => {"name" => "Album 1"},
                    "artists"       => [{"name" => "Artist 1"}],
                    "playlist_id"   => 1
                   }}
    ]
  end

  before do
    allow(music_client).to receive(:playlist_tracks).and_return(track_items)
  end

  describe '#next_track' do
    it "returns the next track in the playlist" do
      track = playlist.next_track
      expect(track.name).to eq(track_items.first["track"]["name"])
    end

    it "removes the returned track from the playlist" do
      track = playlist.next_track
      expect(playlist.tracks).to_not include(track)
    end

    context "when there's no track left" do
      it "reloads the playlist and return a track" do
        playlist.next_track

        new_track = playlist.next_track
        expect(new_track).to_not be_nil
      end
    end
  end

  describe '#tracks' do
    it "returns all the playlist's tracks" do
      expect(playlist.tracks.count).to eq(track_items.count)
    end
  end

  describe '#reload!' do
    it "reloads all the tracks" do
      playlist.tracks
      track_items << { "track" => {"id" => 2,
                                   "name"          => "Track 2",
                                   "album"         => {"name" => "Album 2"},
                                   "artists"       => [{"name" => "Artist 2"}],
                                   "playlist_id"   => 2
                     }}
      playlist.reload!
      expect(playlist.tracks.count).to eq(track_items.count)
    end
  end

end
