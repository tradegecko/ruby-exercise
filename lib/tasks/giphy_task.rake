namespace :giphy do

  desc 'Fetches random gif from Giphy and tweets under @a_giphy_bot'
  task :tweet_random_gif do
    Tasks::TweetRandomGifTask.run
  end
end