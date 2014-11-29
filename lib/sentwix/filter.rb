module Sentwix
  class Filter
    class << self
      def filter_movie_text(tweet_text, movie_title)
        tweet_text.gsub(/#{movie_title}/, '').strip
      end
    end
  end
end
