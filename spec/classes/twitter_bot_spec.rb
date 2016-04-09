require 'rails_helper'

describe TwitterBot do

  before do
    @bot = TwitterBot.new
    @client = @bot.client
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
end
