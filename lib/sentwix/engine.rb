module Sentwix
  class Engine

    # Use 30 here because by Central Limit Theorem, 30 is the
    # minimum sample size required for the distribution of sample
    # means to approach a normal distribution
    TWEETS_SEARCH_LIMIT = 30

    class << self
      def fetch_tweets(movie)
        twitter = TwitterWrapper.new
        search_results = twitter.search(movie.title, result_type: "recent")
                                .take(TWEETS_SEARCH_LIMIT)
        tweets = []
        search_results.each{ |tweet| tweets << Tweet.new(object: tweet.attrs) }
        tweets
      end

      def store_tweets(unpersisted_tweets)
        tweets = []
        unpersisted_tweets.each do |unpersisted_tweet|
          db_tweets = Tweet.where("object -> 'id' = '#{unpersisted_tweet.object['id']}'")
          tweets << (db_tweets.first || unpersisted_tweet.save)
        end
        tweets
      end
    end
  end
end
