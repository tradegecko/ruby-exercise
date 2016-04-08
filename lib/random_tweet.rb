class RandomTweet
	def self.random_tweet
		client = TwitterClient.new
  	client.random_post_tweet
	end
end