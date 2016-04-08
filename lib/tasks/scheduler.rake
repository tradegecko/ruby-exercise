desc "Random Tweet"
task :random_tweet => :environment do
  puts "Random Tweettt"
  RandomTweet.random_tweet
  puts "done."
end