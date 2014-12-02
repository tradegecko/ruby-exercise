desc 'Perform analysis and refresh tweet'
task :run => [:environment] do
  Rake::Task[:tweet].invoke
  Rake::Task[:analysis].invoke
end

desc 'Perform analysis on Movies'
task :analysis => [:environment] do
  puts "Rake task :analysis start"
  Sentwix::Engine.analyze_all_movies
  puts "Rake task :analysis completed"
end

desc 'Tweet movie ratings on my Twitter account'
task :tweet => [:environment] do
  twitter = Sentwix::TwitterWrapper.new

  Movie.active.each do |movie|
    mr = MovieRating.new(movie)
    message = "#{movie.title} | Overall Rating: #{mr.overall_rating}"
    twitter.tweet(message)
  end
end
