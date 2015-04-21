desc "Heroku scheduler add-on tasks"

require 'social/twitter'
task :tweet_and_reply => :environment do
    Twitter.tweet_and_reply
end