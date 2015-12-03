namespace :giphy do
  desc 'Fetches random gif from Giphy and tweets under @a_giphy_bot'
  task :tweet_random_gif, [:date] do |t, args|
    Rails.logger.info 'Starting tweet random gif task...'
    Tweet.tweet_random_gif(args.keyword)
    Rails.logger.info 'Finished tweeting a random gif.'
  end

  desc 'Fetches random gif from Giphy and tweets under @a_giphy_bot'
  task :tweet_random_words do
    Rails.logger.info 'Starting a task to tweet some random words ...'
    Tweet.tweet_random_words
    Rails.logger.info 'Finished the task of tweeting some random words.'
  end
end