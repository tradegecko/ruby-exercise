namespace :twitter_bot do
  desc "Gather tweet data"
  task :gather, [:count] => :environment do |t, args|
    bot = TwitterBot.new
    bot.gather_tweet_data args[:count].to_i
    puts "Gathering tweet data"
  end

  desc "Generate tweet"
  task generate: :environment do
    data = TweetData
    data.generate_tweet
    puts "Generating tweet"
  end

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
  task :all => [:gather,:generate, :tweet, :sync_mentions, :reply]
end

task twitter_bot: 'twitter_bot:all'
