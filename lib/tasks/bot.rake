# This task will tweet a quote from bot
namespace :bot do
  task :tweet_a_quote => :environment do
    Bot.tweet_a_quote
  end
end
