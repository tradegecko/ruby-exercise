desc "checks for twitter mentions and replies to them"
task :check_for_mentions => :environment do
  puts "Checking for mentions..."
  results =  TwitterApiHelper.answer_to_mentions 
  unless results.empty?
    puts "replied to:"
    results.each do |r|
      puts r[:sender] + " " + r[:text]
    end
  else
    puts "No new mentions found"
  end
  puts "done."
end
