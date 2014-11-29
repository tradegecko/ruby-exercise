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

      def store_tweets(tweets)
        tweets.each{ |tweet| tweet.save }
        tweets
      end
    end
  end
end
