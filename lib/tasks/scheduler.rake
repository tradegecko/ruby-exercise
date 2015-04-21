desc "Heroku scheduler add-on tasks"

require 'social/twitter_client'
task :tweet_and_reply => :environment do
    TwitterClient.tweet_and_reply
end