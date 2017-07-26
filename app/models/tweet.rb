class Tweet
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :text

  PREDEFINED_TWEETS = [
    "Find anagrams in others tweets",
    "Look for accidental haiku in tweets and reformat then retweet",
    "Looks for song lyrics in tweets and posts song names",
    "Grabs tweets, puts it through a text-to-speech api and posts a link to the audio",
    "Two bots playing chess together.",
    "Random words from a dictionary",
    "@reply a sample image of a colour if you tweet a hexcode at the bot.",
    "Snowball poems ",
    "Sports results",
    "Battleships"
  ]

  validates :text, :presence => true

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end
end
