desc 'Tweet movie ratings on my Twitter account'
task :tweet => [:environment] do
  twitter = Sentwix::TwitterWrapper.new

  Movie.active.each do |movie|
    mr = MovieRating.new(movie)
    message = "#{movie.title} | Overall Rating: #{mr.overall_rating}"
    twitter.tweet(message)
  end
end
