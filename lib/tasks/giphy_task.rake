namespace :giphy do
  desc 'Fetches random gif from Giphy and tweets under @a_giphy_bot'
  task :tweet_random_gif, [:keyword] do |t, args|
    Rails.logger.info 'Starting tweet random gif task...'
    Tweet.tweet_random_gif(args.keyword || 'a_giphy_bot')
    Rails.logger.info 'Finished tweeting a random gif.'
  end

  desc 'Fetches random gif from Giphy and tweets under @a_giphy_bot'
  task :tweet_random_words do
    Rails.logger.info 'Starting a task to tweet some random words ...'
    Tweet.tweet_random_words
    Rails.logger.info 'Finished the task of tweeting some random words.'
  end

  desc 'stream and reply to tweets under @a_giphy_bot'
  task :reply_to_tweets, [:keyword] do |t, args|
    Rails.logger.info 'Starting a task to stream and reply  ...'
    Tweet.reply_to_the_stream(args.keyword || 'a_giphy_bot')
    Rails.logger.info 'Finished the task of stream and reply.'
  end
end