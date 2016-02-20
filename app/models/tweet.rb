require 'twitter'
class Tweet

  #TODO To move these into env-specific files. Dev keys only.
  def initialize()
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = 'Y4nrwPMb6csBxfwD7DCPWTomZ'
      config.consumer_secret = 'Dt0WthIqye9YpBYl8vRs5NEnX9XZvf0s4BH55hbWLIdNIItwPw'
      config.access_token = '4925659820-kvvktWT7nPITRF5Vh7EPBAAfv0PajDF3m0PUbkH'
      config.access_token_secret = 'M5a7IjAsN9QwaWJWe5jhLh2KI5kKxSPfryTWDtfKBG09V'
    end
  end

  def tweet(tweet_content = "Hola! Nothing to tweet about?")
    begin
      response = @client.update(tweet_content);
      return RequestStatus.new(true, response.text)
    rescue StandardError => e
      return RequestStatus.new(false, e.message)
    end
  end

end