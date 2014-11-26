require 'rails_helper'

describe Sentwix::TwitterWrapper do

  subject { Sentwix::TwitterWrapper.new }

  describe '#search' do
    it 'returns Twitter::SearchResults when topic given' do
      expect(subject.search('test topic')).to be_a Twitter::SearchResults
    end

    it 'returns nil when topic is nil or empty string' do
      expect(subject.search('')).to be_nil
    end
  end

  describe '#tweet' do
    it 'posts a message' do
      expect(subject.tweet("New message")).to be_a Twitter::Tweet
    end
  end

end
