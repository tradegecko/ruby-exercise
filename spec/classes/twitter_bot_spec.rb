require 'rails_helper'

describe TwitterBot do

  before do
    @bot = TwitterBot.new
    @client = @bot.client
  end

  it 'have correct user' do 
    expect(@client.current_user.id.to_s).to eql ENV['bot_id']
  end

  it 'can send tweet' do
    message ||= 'Test Status ' + Time.now.to_s
    @bot.tweet(message)
    expect(@client.home_timeline.first.text).to eql message
  end
end
