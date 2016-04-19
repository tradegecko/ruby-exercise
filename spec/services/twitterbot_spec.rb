require "rails_helper"

RSpec.describe Twitterbot, type: :model do
  subject { Twitterbot.new }
  let(:fake_twitter) { double("Twitter::Client") }
  let(:fake_tweet) { double("Tweet", user: double(screen_name: "Bird"), text: "The whole of Singapore is at Song Kran #sad") }
  
  it 'responds to :post' do
    expect(subject).to respond_to(:post)
  end
  
  context 'with a fake twitter client' do
    before do
      allow(subject).to receive(:twitter_client).and_return(fake_twitter)
    end
    
    it "looks for tweets with #sad" do  
      expect(fake_twitter).to receive(:search).with("#sad")
      subject.post
    end
  
    it "returns nil if the twitter client's search returns nil" do
      allow(fake_twitter).to receive(:search).with("#sad").and_return(nil)
      expect(subject.post).to be_nil
    end
    
    context 'with a fake tweet' do
      before do
        allow(fake_twitter).to receive(:search).with("#sad").and_return([fake_tweet])
      end
      
      it "favourites the tweet" do
        allow(fake_twitter).to receive(:update)
        expect(fake_twitter).to receive(:favorite).with(fake_tweet)
        subject.post
      end
    
      it "updates my status with an inspirational quote" do
        allow(fake_twitter).to receive(:favorite)
        expect(fake_twitter).to receive(:update).with("@Bird Happiness is the art of never holding in your mind the memory of any unpleasant thing that has passed.")
        subject.post
      end
    end
  end
end
