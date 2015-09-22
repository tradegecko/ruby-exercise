class Tweet

  include TweetComposer

  attr_accessor :client

  def initialize
   @client = TwitterApi.new
  end

  def requests
    @client.save_mentions
    @client.reply_unreplied_mentions
  end

  def random_song
    spotify_client = SpotifyApi.new(client.followed_artist)
    message = composed_tweet({
      track_name: spotify_client.track.try(:name),
      artist_name: spotify_client.artist.try(:name),
      player: spotify_client.player
    })
    @client.update(message)
  end

end
