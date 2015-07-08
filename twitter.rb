require 'httparty'
require 'twitter'
require 'pstore'

class Object
  def blank?
    respond_to?(:empty?) ? empty? : !self
  end

  def present?
    !blank?
  end
end

class Angel
  def initialize
    @angel_url = "https://api.angel.co/1"
    @angel_token = ENV["ANGEL_TOKEN"]
  end

  def get_similar startup_name
    @startup = find_startup startup_name
    unless @startup.present?
      puts "Couldn't find the startup from search."
      return false
    end

    puts "Found the startup from search. Getting more info. ID - #{@startup["id"]}"

    fetch_info @startup["id"].to_s
    if @startup["hidden"]
      puts "Startup have it's details hidden. Couldn't proceed."
      return false
    end

    if @startup["markets"].present?
      puts "Got more Info about the Startup. Fetching Market Tags and their children count. ID - #{@startup["id"]}"
      tags_hash = fetch_tag_children @startup["markets"]
    elsif @startup["locations"].present?
      puts "The startup has no Market tags. Fetching from Location tags. ID - #{@startup["id"]}"
      tags_hash = fetch_tag_children @startup["locations"]
    else
      puts "The startup has no Location Tags or Market tags. Couldn't proceed. ID - #{@startup["id"]}"
      return false
    end

    puts "Got Tag Information. Getting startups from the tag. ID - #{@startup["id"]}"
    @similar = {}
    tags_hash.each do |k, v|
      @similar = find_startup_by_tag k
      if @similar.present?
        puts "Found a similar startup!"
        break
      end
    end
    return @similar
  end

  def find_startup startup_name
    params_hash = {
          query: startup_name,
          type: "Startup",
          access_token: @angel_token
        }
    search_url = @angel_url + '/search?' + URI.encode_www_form(params_hash)
    results = get_data search_url

    return results.first
  end

  def fetch_info id
    fetch_url = @angel_url + '/startups/' + id + '?access_token=' + @angel_token
    @startup = get_data fetch_url
  end

  def fetch_tag_children tags
    children = {}
    tags.each do |tag|
      tag_url = @angel_url + '/tags/' + tag["id"].to_s + '?access_token=' + @angel_token
      result = get_data tag_url

      children[tag["id"]] = result["total"]
    end
    Hash[children.sort]
  end

  def find_startup_by_tag tag
    params = {
      access_token: @angel_token,
      page: rand(1..1)
    }
    fetch_url = @angel_url + '/tags/' + tag.to_s + '/startups?' + URI.encode_www_form(params)
    results = get_data fetch_url
    unless results.present?
      return false
    end

    results["startups"].each do |startup|
      if startup["hidden"]
        next
      else
        return {
                :name => startup["name"],
                :summary =>startup["high_concept"]
                }
        break
      end
    end
  end

  def get_data url
    resp = HTTParty.get url
    JSON.parse(resp.body)
  end
end

class Worker
  def initialize config
    @twitter = config
  end

  def process_tweets
    store = PStore.new("tweet.pstore")
    bot_name = ENV["BOT_NAME"]
    last_tweet = store.transaction { store.fetch(:last_tweet, 1) }

    @twitter.mentions_timeline({:since_id => last_tweet}).each do |tweet|
      if last_tweet > tweet.id
        break
      end
      startup = tweet.text.gsub("@" + bot_name, "").strip
      author = tweet.user.screen_name
      puts "Got a new tweet to process from @#{author} on startup - #{startup}. Off to work."

      result = Angel.new.get_similar startup

      puts "Replying to User."
      unless result
        puts "Couldn't find the startup or there were some obstacles."
        post_tweet author, "Couldn't find the startup name, either u've misspelled or i'm drunk.."
      else
        post_tweet author, "Similar: #{result[:name]} - #{result[:summary]}"
      end
      if tweet.id > last_tweet
        last_tweet = tweet.id
      end
    end
    store.transaction do
      store[:last_tweet] = last_tweet
    end
  end

  def post_tweet author, message
    @twitter.update "@#{author}: #{message}"
  end
end

twitter_config = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["TWITTER_API_KEY"]
  config.consumer_secret     = ENV["TWITTER_API_SECRET"]
  config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
  config.access_token_secret = ENV["TWITTER_ACCESS_SECRET"]
end

twitter = Worker.new twitter_config
twitter.process_tweets

puts "All Done! Going to sleep."
