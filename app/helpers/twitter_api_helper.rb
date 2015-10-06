module TwitterApiHelper 

  def TwitterApiHelper.initClient
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "vnZffQpHom39ewCmM6xkk1Ve6"
      config.consumer_secret     = "Ftc7XwTndlbrbc3s71VfF2G4OSgdZRicsN971nZMV1AIHW0i37"
      config.access_token        = "3791732720-wtRG6G14r7Au6o37HVZJgmrYOJdYdksriPmLBix"
      config.access_token_secret = "yGluyaOq51LbBjzvtW1r2EAWEnyJb3bFzyk8pZsVf4XfH"
    end
    client
  end

  def TwitterApiHelper.getUserName
    client = initClient
    user = client.user("fxsperling")
    user.name
  end

  def TwitterApiHelper.answerToMentions
    client = initClient
    lastMention = client.mentions_timeline(:count => 1)[0]
    text = lastMention.text
    sender = lastMention.user.screen_name    
    
    #  :in_reply_to_status (Twitter::Tweet)
    client.update("Hi @#{sender}, how are you?")

    text
  end

end

