require 'twitter'

class TwitterClient

  def initialize
    @client = init
  end

  def search_tweets_with_images_by_keyword keyword
    query_str = build_query_str(keyword)
    @client.search(query_str, {result_type: 'recent', count: 1})
  end

  private

  def build_query_str keyword
    array = Array.new
    array << keyword
    array = add_filter_image array
    array = add_filter_no_rt array
    query_str = array.join(' ')
  end

  def add_filter_image array
    array << 'filter:images'
  end

  def add_filter_no_rt array 
    array << '-RT'
  end

  def init
    Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end
  end  
end
