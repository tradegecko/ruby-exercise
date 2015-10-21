require 'wikipedia'
require 'twitter'
require 'logger'

class TwitterApi
  @log = Logger.new('log/app.log')

  def init_client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY'] 
      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end
  end

  def answer_to_mentions
    client = init_client
    begin
      lastMentions = client.mentions_timeline(count: 10)
    rescue
      log.error "Could not get mentions"
    end
    activity = [] 

    lastMentions.each do |mention|
      unless AnsweredMention.where(tweet_id: mention.id).exists?
        text = mention.text
        sender = mention.user.screen_name    
        activity.push({sender: sender, text: text})
        reply = process_mention(sender, text)

        begin
          client.update(reply)
        rescue 
          log.error "Could not send tweet '#{reply}'"
          next
        end
        AnsweredMention.new(tweet_id: mention.id).save
      end
    end 

    activity
  end

  def process_mention(sender, text)
    if text.include? "!w"
      query = text.sub(/^.*!w(.*)/, '\1').strip
      begin
        page = Wikipedia.find(query)
      rescue
        log.error "Could not retrieve page #{query} from Wikipedia"
      end
      tweet = "@#{sender} #{page.text}"
      reply = tweet.slice(0,140)
    else 
      now = Time.now.strftime("%T")
      reply = "Hi @#{sender}, how are you? Did you know it's #{now} already?"
    end

    reply
  end
end

