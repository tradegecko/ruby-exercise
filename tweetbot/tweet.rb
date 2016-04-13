class Tweet
  def self.send(body = "")
    if body.empty?
      #tweet a random gif with random emojis
      rand(1..3).times { body << Emoji.random }
      body << " " << Gif.get_trending
    else
      body = body.to_s
    end
    CLIENT.update(body)
  end
end