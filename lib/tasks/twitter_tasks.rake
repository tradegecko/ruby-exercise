# Tasks to kick off the Twitter API interactions
namespace 'twitter' do
  desc 'should always be running. handles incoming tweets, responds, and counts senders'
  task handle_tweets: :environment do
    TweetStreamProcessor.run
  end
end
