require 'rails_helper'

describe Mention do

  let!(:unreplied_mention) { create :mention, status: "unreplied" }
  let!(:another_unreplied_mention) do
    Hashie::Mash.new({
     id: 2,
     user: { screen_name:  "iallenchun" },
     user_mentions: [ {name: "Maroon 5"} ]
    })
  end

  describe "validations" do
    it "checks presence of mention_id" do
      expect(subject).to validate_presence_of :mention_id
    end

    it "checks uniqueness of mention_id" do
      expect(subject).to validate_uniqueness_of :mention_id
    end

    it "checks presence of reply_to" do
      expect(subject).to validate_presence_of :reply_to
    end

    it "checks presence of mentioned_user" do
      expect(subject).to validate_presence_of :mentioned_user
    end
  end

  describe ".scopes" do
    describe ".unreplied_mentions" do
      it "returns unreplied mentions" do
        expect(Mention.unreplied_mentions).to include unreplied_mention
      end
    end
  end


  describe ".save_mentions" do
    it "finds or create new mention" do
      expect{ Mention.save_mention(another_unreplied_mention) }.to change(Mention, :count).by(1)
    end
  end

end

