desc "This task is called by the Heroku scheduler add-on"
task :tweet_usd_myr => :environment do
  currency = Currency.find_by(code: 'MYR')
  TweetForm.new({ currency_id: currency.id}).create
  puts 'Tweet sent!'
end

