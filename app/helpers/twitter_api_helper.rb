module TwitterApiHelper 
  require 'wikipedia'

  def self.init_client
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "vnZffQpHom39ewCmM6xkk1Ve6"
      config.consumer_secret     = "Ftc7XwTndlbrbc3s71VfF2G4OSgdZRicsN971nZMV1AIHW0i37"
      config.access_token        = "3791732720-wtRG6G14r7Au6o37HVZJgmrYOJdYdksriPmLBix"
      config.access_token_secret = "yGluyaOq51LbBjzvtW1r2EAWEnyJb3bFzyk8pZsVf4XfH"
    end
    client
  end

  def self.answer_to_mentions
    client = init_client
    lastMentions = client.mentions_timeline(:count => 10)
    activity = [] 

    lastMentions.each do |mention|
      unless Answeredmention.where(tweetid: mention.id).exists?
        text = mention.text
        sender = mention.user.screen_name    
        activity.push({sender: sender, text: text})
       
        if text.include? "!w"
          query = text.sub(/^.*!w(.*)/, '\1').strip
          page = Wikipedia.find(query)
          startOfPage = page.text.slice(0,120)
          client.update("@#{sender} #{startOfPage}")
        else 
          now = Time.now.strftime("%T")
          client.update("Hi @#{sender}, how are you? Did you know it's #{now} already?")
        end

        Answeredmention.new(tweetid: mention.id).save
      end
    end 

    activity
  end
end

