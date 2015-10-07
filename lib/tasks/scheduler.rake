desc "checks for twitter mentions and replies to them"
task :check_for_mentions => :environment do
  puts "Checking for mentions..."
  puts TwitterApiHelper.answerToMentions 
  puts "done."
end
