task :reply_to_mentions => :environment do
  Reply.to_all_mentions
end