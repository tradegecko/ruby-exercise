require 'ejaydj/services/track_service'

module Ejaydj
  class Playlist
    attr_reader :id,
                :user_id,
                :name,
                :url,
                :number_of_tracks

    def initialize(attributes={})
      @id               = attributes[:id]
      @user_id          = attributes[:user_id]
      @name             = attributes[:name]
      @url              = attributes[:url]
      @number_of_tracks = attributes[:number_of_tracks]

      @music_client     = attributes[:music_client]
    end

    def next_track
      reload! if tracks.empty?
      track = tracks.pop
      track.playlist = self
      track
    end

    def tracks
      @tracks ||= all_tracks
    end

    def reload!
      @tracks = all_tracks
    end

    private

    def all_tracks
      track_service.all.shuffle
    end

    def track_service
      @track_service ||= Services::TrackService.new(
                                          music_client: @music_client,
                                          user_id: @user_id,
                                          playlist_id: @id)
    end
  end
end
