desc 'Perform analysis on Movies'
task :analysis => [:environment] do
  puts "Rake task Analysis start"
  results = Movie.analyze_all
  results.each do |result|
    title = result[:movie].title.truncate(27)
    rating = result[:result].map{ |pair| "#{pair[0]}-#{pair[1]}" }.join(" ")
    message = "#{title} => #{rating}"
    Sentwix::TwitterWrapper.new.tweet(message)
  end
  puts "Rake task Analysis completed"
end
