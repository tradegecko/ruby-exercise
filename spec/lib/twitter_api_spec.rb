require 'rails_helper'

RSpec.describe TwitterApi do
  let(:api) { TwitterApi.new }
  describe '#find_tweets_with_images_by_keyword' do
    subject { api.find_tweets_with_images_by_keyword('dream') }
    it { is_expected.to be_a Array }
    its(:count) { is_expected.to eql 100 }
    its(:first) { is_expected.to be_a Twitter::Tweet }
  end
end
