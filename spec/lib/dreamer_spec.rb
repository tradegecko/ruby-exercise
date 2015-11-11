require 'rails_helper'

RSpec.describe Dreamer do
  subject(:dreamer) { Dreamer.send(:new, 'dream') }
  describe '#dream_image' do
    subject { dreamer.send(:dream_image) }
    it { is_expected.to be_a DreamImage }
    its(:twitter_id) { is_expected.to be }
    its(:image_url) { is_expected.to be }

    context "no new images" do
      before do
        allow(DreamImage).to receive(:exists?) { true }
      end
      it 'raises error' do
        expect{ subject }.to raise_error
      end
    end
  end

  describe '.dream' do
    let(:media) { instance_double('media', {media_url: 'http://i.huffpost.com/gen/1541850/images/o-ASHAMED-DOG-facebook.jpg'}) }
    let(:user) { instance_double('user', {screen_name: 'john_doe'})  }
    let(:tweet_with_image) do
      instance_double('Twitter::Tweet', id: 42,
              media: [media],
              user: user,
              text: "Sample tweet")
    end
    it "tweets with an image" do
      allow_any_instance_of(TwitterApi).to \
        receive(:find_tweets_with_images_by_keyword) { [tweet_with_image] }
      expect_any_instance_of(TwitterApi).to receive(:tweet)
      Dreamer.dream('dream')
    end
  end


end
