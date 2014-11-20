module Ejaydj
  module Services
    class PlaylistService

      def initialize(music_client: nil, user_id: nil)
        @music_client = music_client
        @user_id      = user_id
      end

      def all
        response_items = @music_client.user_playlists(user_id: @user_id)

        response_items.map do |playlist|
          Playlist.new(
            id:                 playlist["id"],
            user_id:            playlist["owner"]["id"],
            name:               playlist["name"],
            url:                playlist["external_urls"]["spotify"],
            number_of_tracks:   playlist["tracks"]["total"],

            music_client:       @music_client)
        end
      end

    end
  end
end
