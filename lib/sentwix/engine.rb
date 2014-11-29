module Sentwix
  class Engine

    # Use 30 here because by Central Limit Theorem, 30 is the
    # minimum sample size required for the distribution of sample
    # means to approach a normal distribution
    #
    # Keep this to minimum required because there is a limit of how much
    # sentiment analysis we can do in a peroid of time.
    TWEETS_SEARCH_LIMIT = 30

    class << self

      def analyze_all_movies
        Movie.all.each{ |movie| analyze(movie) }
      end

      def analyze(movie)
        new_tweets = fetch_tweets(movie)
        persisted_tweets = store_tweets(new_tweets)
        persisted_tweets.select{ |t| t.sentiment.nil? }.each do |tweet|
          TweetSentimentWorker.perform_async(tweet.id)
        end
        analysis = Analysis.create(tweets: persisted_tweets)
      end

      def fetch_tweets(movie)
        twitter = TwitterWrapper.new
        search_results = twitter.search(movie.title, result_type: "recent")
                                .take(TWEETS_SEARCH_LIMIT)
        tweets = []
        search_results.each{ |tweet| tweets << Tweet.new(object: tweet.attrs, movie_id: movie.id) }
        tweets
      end

      def store_tweets(unpersisted_tweets)
        tweets = []
        unpersisted_tweets.each do |unpersisted_tweet|
          db_tweets = Tweet.where("object -> 'id' = '#{unpersisted_tweet.object['id']}'")
          tweets << (db_tweets.first || Tweet.create(unpersisted_tweet.attributes))
        end
        tweets
      end

    end
  end
end
