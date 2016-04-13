require 'test_helper'

class TwitterBotTest < ActiveSupport::TestCase
  context 'Initialisation of twitter bot' do
    setup do
      @twitter_bot_config = Rails.application.secrets.twitter_accounts[0]
      @twitter_account = Twitter::REST::Client.new do |config|
        config.consumer_key        = @twitter_bot_config['consumer_key']
        config.consumer_secret     = @twitter_bot_config['consumer_secret']
        config.access_token        = @twitter_bot_config['access_token']
        config.access_token_secret = @twitter_bot_config['access_token_secret']
      end
    end

    should 'create a twitter bot that can access to twitter' do
      twitter_bot = TwitterBot.new(
          @twitter_bot_config['consumer_key'],
          @twitter_bot_config['consumer_secret'],
          @twitter_bot_config['access_token'],
          @twitter_bot_config['access_token_secret'],
      )
      assert_equal @twitter_account.verify_credentials.screen_name, twitter_bot.screen_name
    end
  end
end
