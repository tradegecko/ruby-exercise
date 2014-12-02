require 'rails_helper'

describe AlchemyAPI, :vcr do
  describe '.sentiment' do

    subject { AlchemyAPI }
    let(:data) { "I am thinking of some ice cream" }

    it 'raise error when text is empty string' do
      expect{ subject.sentiment('') }.to raise_error AlchemyAPI::DataInvalidError
    end

    it 'raise error when text is nil' do
      expect{ subject.sentiment(nil) }.to raise_error AlchemyAPI::DataInvalidError
    end

    it 'returns results a sentiment analysis given text' do
      expect(subject.sentiment(data).keys).to include 'docSentiment'
    end

  end
end
