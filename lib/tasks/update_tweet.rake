#The rake task is use with heroku scheduler to call the method "Post" evry hour.
namespace :tweet do
  desc "TODO"
  task :update_tweet => :environment do
   tweet = Twitterbot.new.post
  end
end
