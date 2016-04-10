require 'rails_helper'

describe TwitterBot, :vcr, record: :once do

  before do
    @bot = TwitterBot.new
    @client = @bot.client
    create :tweet_datum
  end

  it 'have correct user' do 
    expect(@client.current_user.id.to_s).to eql ENV['bot_id']
  end

  it "will tweet the oldest Tweet that hasn't been tweeted yet" do
    tweet = create :tweet
    @bot.tweet
    expect(@client.home_timeline.first.text).to eql tweet.content
  end

  it 'will not tweet the Tweet that has been tweeted' do
    tweet = create :tweet
    tweet.tweet!
    @bot.tweet
    expect(@client.home_timeline.first.text).not_to eql tweet.content
  end

  describe '#sync_mentioned' do
    it 'saves mentions to Mention' do 
     #TODO: Find a way to mock unread mentions and use it to test because it changes everytime
    end
  end
end
