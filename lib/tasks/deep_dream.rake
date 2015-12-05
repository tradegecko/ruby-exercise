desc "This task is called by the Heroku scheduler add-on to perform dream job"
task :deep_dream => :environment do
  puts "Dreaming..."
  DeepDreamer.dream
  puts "Done."
end
