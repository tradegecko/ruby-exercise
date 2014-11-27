require 'sentwix/twitter_wrapper'
require 'alchemy_api'

module Sentwix

  class InvalidMovieError < StandardError; end

  DATA_UNAVAILABLE = "unavailable"
  SEARCH_DATA_LIMIT = 50
  SENTIMENT_ANALYSIS_LIMIT = 10

  def self.analyze_movie(movie_title)
    raise InvalidMovieError if movie_title.nil? || movie_title.strip.empty?

    twitter = TwitterWrapper.new
    search_results = twitter.search(movie_title, {count: SEARCH_DATA_LIMIT})

    analysis = []
    search_results.each_with_index do |tweet, index|
      break if index == SENTIMENT_ANALYSIS_LIMIT
      # Sadly, combined call (multiple text analysis in one request) in only 
      # available for Pro and Enterprise. Limit the analysis here to prevent
      # from taking too much time.

      sen_result = AlchemyAPI.sentiment(tweet.full_text)
      sen_type = sen_result['docSentiment'] ?
        sen_result['docSentiment']['type'] : DATA_UNAVAILABLE

      analysis << {
        text: tweet.full_text,
        type: sen_type
      }
    end

    analysis.group_by{ |item| item[:type] }
            .map{ |type, group| [type, group.count] }
  end

end
