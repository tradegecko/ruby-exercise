desc 'Perform analysis and refresh tweet'
task :run => [:environment] do
  Rake::Task[:analysis].invoke
  Rake::Task[:refresh_tweets].invoke
end

desc 'Perform analysis on Movies'
task :analysis => [:environment] do
  puts "Rake task :analysis start"
  results = Movie.analyze_all
  results.each do |result|
    title = result[:movie].title.truncate(60)
    rating = result[:result].map{ |pair| "#{pair[0]}-#{pair[1]}" }.join(" ")
    message = "#{title}. Scoring: #{rating}"
    Sentwix::TwitterWrapper.new.tweet(message)
  end
  puts "Rake task :analysis completed"
end

desc 'Get Tweets from Twitter and cache in DB'
task :refresh_tweets => [:environment] do
  puts "Rake task :refresh_tweets start"

  ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{::Tweet.table_name}")

  twitter = Sentwix::TwitterWrapper.new
  tweets = twitter.user_timeline
  tweets.each do |tweet|
    record = ::Tweet.new(
      created_at: tweet.created_at,
      text: tweet.text
    )
    record.save!
  end

  puts "Rake task :refresh_tweets completed"
end
