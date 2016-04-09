require 'rails_helper'

RSpec.describe Tweet, type: :model do
  subject(:tweet) { build :tweet }

  it { is_expected.to be_valid }
  its(:aasm_state) { is_expected.to eql "untweeted" }

  describe 'Validations' do
    context 'when content is empty' do
      before do
        subject.content = ''
      end

      it { is_expected.not_to be_valid }
    end
  end

  describe "Associations" do
    it "should belongs_to Mention" do
      mention = create :mention
      mention.tweets << subject
      expect(subject.mention).to eql mention
    end
  end

  describe "Scope" do
    describe "#unsent" do
      it "should not include reply tweets" do
        tweet = create :tweet, reply: true
        expect(Tweet.unsent).not_to include tweet
      end
    end

    describe "#unreplied" do
      it "should include reply tweets" do
        tweet = create :tweet, reply: true
        expect(Tweet.unreplied).to include tweet
      end

      it "should only include reply tweets" do
        tweet = create :tweet, reply: false
        expect(Tweet.unreplied).not_to include tweet
      end
    end
  end
end
