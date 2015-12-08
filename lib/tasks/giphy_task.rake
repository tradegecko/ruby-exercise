namespace :giphy do
  desc 'Fetches random gif from Giphy and tweets under @a_giphy_bot'
  task :tweet_random_gif, [:keyword] => :environment do |t, args|
    puts 'Starting tweet random gif task...'
    Tweet.tweet_random_gif(args.keyword || 'a_giphy_bot')
    puts 'Finished tweeting a random gif.'
  end

  desc 'Fetches random gif from Giphy and tweets under @a_giphy_bot'
  task :tweet_random_words, [:keyword] => :environment do |t, args|
    puts 'Starting a task to tweet some random words ...'
    Tweet.tweet_random_words(args.keyword || 'a_giphy_bot')
    puts 'Finished the task of tweeting some random words.'
  end

  desc 'stream and reply to tweets under @a_giphy_bot'
  task :reply_to_tweets, [:keyword] => :environment do |t, args|
    puts 'Starting a task to stream and reply  ...'
    Tweet.reply_to_the_stream(args.keyword || 'a_giphy_bot')
    puts 'Finished the task of stream and reply.'
  end
end