require 'rails_helper'

RSpec.describe Mention, type: :model do
  subject(:mention) { build :mention }

  before do
    create :tweet_datum
  end

  it { is_expected.to be_valid }

  its(:aasm_state) { is_expected.to eql "unanalyzed" }

  describe "Associations" do
    it "should have many tweet" do
      mention = create :mention
      expect {
        mention.tweets.create(content: mention.reply_content, reply: true)
      }.to change(Tweet, :count).by 1
    end
  end

  describe "after_create" do
    it "should create new Tweet" do
      expect{
        create :mention
      }.to change(Tweet, :count).by 1
    end
  end
end
