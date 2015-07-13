# This will kick off the twitter stream processor
namespace :twitter_streamer do
  task :start => :environment do
    TwitterStreamer.start
  end
end
