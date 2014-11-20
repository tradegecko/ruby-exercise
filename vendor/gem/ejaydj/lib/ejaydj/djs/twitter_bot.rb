require 'twitter'
require 'googl'

module Ejaydj
  module Djs
    class TwitterBot < Ejaydj::Dj
      attr_accessor :twitter_consumer_key,
                    :twitter_consumer_secret,
                    :twitter_access_token,
                    :twitter_access_token_secret,
                    :twitter_client

      MAX_SONG_LENGTH   = 50
      MAX_ARTIST_LENGTH = 50

      def initialize(attributes={}, &block)
        super(attributes, &block)
      end

      def tweet_me_a_song(time: Time.now)
        @song = play_me_a_song(time: time)
        tweet = tweet_string

        twitter_client.update(tweet)

        {message: tweet, song: @song}
      end

      private

      def tweet_string
        tweet_string = ("NP: #{@song.name} by #{@song.artist} from playlist: #{shorten_url(@song.playlist.url)}")
        shorten_tweet(tweet_string)
      end

      def shorten_tweet(tweet_string)
        return tweet_string unless tweet_string.length > 140

        @song.name    = "#{@song.name[0..MAX_SONG_LENGTH]}..." if @song.name.length > MAX_SONG_LENGTH
        @song.artist  = "#{@song.artist[0..MAX_ARTIST_LENGTH]}..." if @song.artist.length > MAX_ARTIST_LENGTH

        "NP: #{@song.name} by #{@song.artist} | #{shorten_url(@song.playlist.url)}"
      end

      def shorten_url(url)
        Googl.shorten(url).short_url
      end

      def twitter_client
        @twitter_client ||= Twitter::REST::Client.new do |config|
          config.consumer_key        = @twitter_consumer_key
          config.consumer_secret     = @twitter_consumer_secret
          config.access_token        = @twitter_access_token
          config.access_token_secret = @twitter_access_token_secret
        end
      end
    end
  end
end
