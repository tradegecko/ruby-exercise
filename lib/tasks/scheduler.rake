desc "Post random tweet hourly"
task :tweet_random_tweet => :environment do
  puts "Putting random tweet..."
  response = Tweet.new.tweet_random_quote
  puts "Random tweet posted: #{response.message}"
end

desc "Check and responds to tweets every 5 minutes"
task :tweet_respond_tweets => :environment do
  puts "Checking Replying to tweets..."
  response = Tweet.new.respond_tweet
  puts "Replied: #{response.message}"
end