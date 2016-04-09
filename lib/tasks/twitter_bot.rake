namespace :twitter_bot do
  desc "Send a tweet"
  task send_tweet: :environment do
    bot = TwitterBot.new
    bot.tweet
  end
end
