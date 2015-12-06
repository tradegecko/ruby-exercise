require 'rails_helper'

RSpec.describe TwitterClient do
  # too much test will trigger twitter rate limits
  # Be careful
  let(:client) { TwitterClient.new }

  describe "#new" do
    it "returns a new TwitterClient instance" do
      client.should be_an_instance_of TwitterClient
    end
  end

  describe '#search_tweets_with_images_by_keyword' do
    let(:results) { client.search_tweets_with_images_by_keyword('dream') }

    it "should take a keyword and return a instance of Twitter::SearchResults" do
      results.should be_an_instance_of Twitter::SearchResults
    end

    it "inside results the first element should be an instance of tweet" do
      results.first.should be_an_instance_of Twitter::Tweet
    end

    it "the first tweet should contain the specified keyword" do
      results.first.full_text.downcase.should include('dream')
    end
  end

  it "#build_query_str returns correct string" do
    query = client.send(:build_query_str, 'test')
    query.should eql 'test filter:images -RT'
  end

  describe "#tweet_dreamed_image" do
    file_path = file_path = File.join Rails.root, 'public', 'rspec.png'
    let(:tweet) { client.tweet_dreamed_image("rspec test tweet @rspec #rspec", File.new(file_path)) }

    it "should returns an instance of tweet" do
      tweet.should be_an_instance_of Twitter::Tweet
    end

    it "the tweet should contain the status text" do
      tweet.full_text.should include('rspec test tweet @rspec #rspec')
    end

    it "the tweet should has media" do
      tweet.media?.should eql(true)
    end
  end

end
