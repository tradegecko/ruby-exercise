desc 'Perform analysis and refresh tweet'
task :run => [:environment] do
  Rake::Task[:analysis].invoke
end

desc 'Perform analysis on Movies'
task :analysis => [:environment] do
  puts "Rake task :analysis start"
  Sentwix::Engine.analyze_all_movies
  puts "Rake task :analysis completed"
end
