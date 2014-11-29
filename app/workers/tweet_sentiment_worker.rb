class TweetSentimentWorker
  include Sidekiq::Worker

  def perform(tweet_id)
    tweet = Tweet.find(tweet_id)
    if tweet && tweet.sentiment.nil?
      text = Sentwix::Filter.filter_movie_text(tweet.object['text'], tweet.movie.title)

      sen_result = AlchemyAPI.sentiment(text)
      if sen_type = sen_result['docSentiment']
         tweet.sentiment = sen_result['docSentiment']['type']
         tweet.save
         tweet.analyses.each{ |analysis| analysis.populate_analysis }
      else
        raise AlchemyAPI::ServiceUnavailableError.new, "Error details: #{sen_result}"
      end
    end
  end
end
