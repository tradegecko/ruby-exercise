module TweetComposer

  def composed_tweet(options = {})
    if options[:reply_to].present?
      "Hi @#{options[:reply_to]} here's \"#{options[:track_name]}\" by #{options[:artist_name]} listen now on #{options[:player]}"
    else
      "NP: \"#{options[:track_name]}\" by #{options[:artist_name]} listen now on #{options[:player]}"
    end
  end

end
