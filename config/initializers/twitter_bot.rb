TWITTER_BOTS = []
Rails.application.secrets.twitter_accounts.each do |twitter_bot|
  TWITTER_BOTS.push(
      TwitterBot.new(
          twitter_bot['consumer_key'],
          twitter_bot['consumer_secret'],
          twitter_bot['access_token'],
          twitter_bot['access_token_secret']
      )
  )
  Thread.new do
    TWITTER_BOTS.last.listen_to_timeline
  end
end
