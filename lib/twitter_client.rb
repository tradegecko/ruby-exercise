class TwitterClient
	
	def initialize
		@client = twitter_credentials
	end

	def post_tweet(result)
		coordinate(result)
		@client.update("Visitor from #{result}: The weather is #{@forecast.summary} and #{@forecast.temperature} celsius")
	end

	def random_post_tweet
		coordinate(nil)
		@client.update("Today's Random City: #{@city}'s weather is #{@forecast.summary} and #{@forecast.temperature} celsius")
	end

	def coordinate(result)
		if result.nil?
			random_lat, random_long = Random.new.rand(-90..90) , Random.new.rand(-180..180)
			while (location = (Geocoder.search("#{random_lat}, #{random_long}"))) == []
				location = (Geocoder.search("#{random_lat}, #{random_long}"))
			end		
			location[0].city.empty? ? @city = 'Unknown City' : @city = location[0].city
		else
			@city = result
		end
		lat, long = location[0].latitude, location[0].longitude
		@forecast = ForecastIO.forecast(lat, long, params: { units: 'si' }).currently
	end

	private

	def twitter_credentials
		Twitter::REST::Client.new do |config|
		  config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
	    config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
	    config.access_token = ENV['TWITTER_ACCESS_TOKEN']
	    config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
	  end
	end

end