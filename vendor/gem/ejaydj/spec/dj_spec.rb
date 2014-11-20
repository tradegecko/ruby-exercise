require 'spec_helper'

RSpec.describe Ejaydj::Dj do

  let(:dj) do
    Ejaydj::Dj.new do |config|
      config.music_user_id        = 'user_1'
      config.music_client_id      = 'client_1'
      config.music_client_secret  = 'client_secret_1'
      config.music_client         = music_client
      config.morning_playlists    = ["Morning Playlist"]
      config.noon_playlists       = ["Noon Playlist"]
      config.night_playlists      = ["Night Playlist"]
      config.late_night_playlists = ["Late Night Playlist"]
    end
  end

  let(:playlist_items) do
    [
      {"name" => "Morning Playlist", "owner" => {"id" => 1}, "external_urls" => {"spotify" => "/playlist_morning"}, "tracks" => {"total" => 10}},
      {"name" => "Noon Playlist", "owner" => {"id" => 2}, "external_urls" => {"spotify" => "/playlist_noon"}, "tracks" => {"total" => 10}},
      {"name" => "Night Playlist", "owner" => {"id" => 3}, "external_urls" => {"spotify" => "/playlist_night"}, "tracks" => {"total" => 10}},
      {"name" => "Late Night Playlist", "owner" => {"id" => 4}, "external_urls" => {"spotify" => "/playlist_late_night"}, "tracks" => {"total" => 10}}
    ]
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

  let(:music_client) { double('MusicClient') }

  before do
    allow(music_client).to receive(:user_playlists).and_return(playlist_items)
    allow(music_client).to receive(:playlist_tracks).and_return(track_items)
  end

  describe '#play_me_a_song' do
    context "when played in the morning" do
      it "plays the song from the morning playlists" do
        song = dj.play_me_a_song(time: Time.new(2014, 11, 20, 6, 30, 0))
        expect(dj.morning_playlists).to include(song.playlist.name)
      end
    end

    context "when played in the noon" do
      it "plays the song from the noon playlists" do
        song = dj.play_me_a_song(time: Time.new(2014, 11, 20, 17, 45, 0))
        expect(dj.noon_playlists).to include(song.playlist.name)
      end
    end

    context "when played in night" do
      it "plays the song from the night playlists" do
        song = dj.play_me_a_song(time: Time.new(2014, 11, 20, 18, 0, 0))
        expect(dj.night_playlists).to include(song.playlist.name)
      end
    end

    context "when played in late night" do
      it "plays the song from the late night playlists" do
        song = dj.play_me_a_song(time: Time.new(2014, 11, 20, 23, 15, 0))
        expect(dj.late_night_playlists).to include(song.playlist.name)
      end
    end
  end

  describe '#playlists' do
    it "returns all the dj's playlists" do
      expect(dj.playlists.count).to eq(playlist_items.count)
    end
  end

  describe '#reload!' do
    it "reloads the playlist" do
      dj.playlists
      playlist_items << {"name" => "Morning Playlist 2", "owner" => {"id" => 5}, "external_urls" => {"spotify" => "/playlist_morning_2"}, "tracks" => {"total" => 10}}
      dj.reload!

      expect(dj.playlists.count).to eq(playlist_items.count)
    end

    it "reloads the playlist's tracks" do
      dj.playlists.first.tracks
      track_items << { "track" => {"id" => 2,
                                   "name"          => "Track 2",
                                   "album"         => {"name" => "Album 2"},
                                   "artists"       => [{"name" => "Artist 2"}],
                                   "playlist_id"   => 2
                     }}
      dj.reload!
      expect(dj.playlists.first.tracks.count).to eq(track_items.count)
    end
  end

end
