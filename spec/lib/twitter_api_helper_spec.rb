require 'spec_helper'
require 'twitter_api_helper'

describe TwitterApiHelper do
  let!(:twitterapihelper) { TwitterApiHelper.new } 

  describe "init" do
    it "should setup a twitter client" do
      expect(twitterapihelper.init_client).to_not be_nil
    end
  end

  describe "reply" do
    sender = "myName"

    it "should reply with sendername" do
      reply = twitterapihelper.process_mention(sender, "bla")
      expect(reply).to match(/@#{sender}/)
    end

    it "should send generic reply if no commands are found" do
      generictext = "Hallo Bot"
      reply = twitterapihelper.process_mention(sender, generictext)
      expect(reply).to match(/how are you/)
    end

    it "should check mentions for commands" do
      textwithcmd = "@botname !w word"
      reply = twitterapihelper.process_mention(sender, textwithcmd)
      expect(reply).to_not match(/how are you/)
    end
  end


end
