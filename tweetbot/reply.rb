class Reply
  def self.generate_reply_to(tweet)
    num, gif = 1, nil #words[0] is the @username
    words = tweet.text.split(" ")
    while num <= words.length && !gif
      tag = words[num].gsub(/[^0-9a-z ]/i, '')
      if tag.empty? || !Gif.get(tag) 
        if words.length <= 2
          return "please talk to me in English"
        end
        num += 1
      else
        return Gif.get(tag)
      end
    end
  end

  def self.check_mentions
    mentions = Mention.all
    last_mention_id = mentions.any? ? mentions.last.tweet_id.to_i : 1
    options = {
      since_id: last_mention_id,
      count:  200
    }
    CLIENT.mentions_timeline(options)
  end

  def self.to_all_mentions
    new_mentions = check_mentions
    if new_mentions.any?
      for tweet in new_mentions do
        reply = generate_reply_to(tweet) + " " + Emoji.random
        unless Mention.where(tweet_id: tweet.id.to_s).any? 
          if CLIENT.update("@#{tweet.user.screen_name} " + reply, in_reply_to_status_id: tweet.id)
            Mention.create(tweet_id: tweet.id, answered: true)
          end
        end
      end
    end
  end
end