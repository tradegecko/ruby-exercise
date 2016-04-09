namespace :twitter_bot do
  desc "Send a tweet"
  task tweet: :environment do
    bot = TwitterBot.new
    bot.tweet
    puts "Sending tweet"
  end

  desc "Send replies"
  task reply: :environment do
    bot = TwitterBot.new
    bot.reply
    puts "Sending replies"
  end


  desc "Sync mentioned data"
  task sync_mentions: :environment do
    bot = TwitterBot.new
    bot.sync_mentions
    puts "Syncing mentions"
  end

  desc "Create all survey templates"
  task :all => [:tweet, :sync_mentions, :reply]
end

task twitter_bot: 'twitter_bot:all'
