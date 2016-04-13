task :send_tweet => :environment do
  Tweet.send
end