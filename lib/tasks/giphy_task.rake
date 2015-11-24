namespace :giphy do

  desc 'Fetches random gif from Giphy and tweets under @a_giphy_bot'
  task :tweet_random_gif, [:date] do |t, args|
    GiphyBot.tweet_random_gif(args.keyword)
  end
end