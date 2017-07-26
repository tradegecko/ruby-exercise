desc "Just tweet a random comment"
task :tweet_something => :environment do
  TwitterAdapter.new.tweet(Tweet::PREDEFINED_TWEETS.sample)
end
