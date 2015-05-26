# Tasks to kick off the Twitter API interactions
namespace 'twitter' do
  desc 'should always be running. handles incoming tweets, responds, and counts senders'
  task handle_tweets: :environment do
    TweetStreamProcessor.run
  end

  desc 'designed to be called once per hour. will check redis to see who tweeted at
    the bot the most, and will be sad if no one did.'
  task plz_to_tweet_me: :environment do
    PlzToTweetMe.run
  end
end
