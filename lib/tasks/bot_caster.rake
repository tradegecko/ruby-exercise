namespace :tweet do

  desc "Tweets a random song from your followed artists"
  task random_song: :environment do
    Tweet.new.random_song
  end

  desc "Sends requested songs to unreplied mentions"
  task request: :environment do
    Tweet.new.requests
  end

end

