require 'rails_helper'

describe Analysis do
  describe 'associations' do
    it { should belong_to :movie }
    it { should have_many :analysis_tweets }
    it { should have_many(:tweets).through(:analysis_tweets) }
  end

  describe '#populate_analysis' do
    it 'should count and populate the sentiments when tweets available' do
      tweet1 = FactoryGirl.create(:tweet, sentiment: 0)
      tweet2 = FactoryGirl.create(:tweet, sentiment: 1)
      tweet3 = FactoryGirl.create(:tweet, sentiment: -1)
      analysis = Analysis.create
      analysis.tweets << [tweet1, tweet2, tweet3]
      analysis.populate_analysis

      results = %w(positive neutral negative).map { |method| analysis.send(method) }
      expect(results).to eq [1,1,1]
    end

    it 'should count and populate sentiments when no tweets available' do
      analysis = Analysis.create
      analysis.populate_analysis

      results = %w(positive neutral negative).map { |method| analysis.send(method) }
      expect(results).to eq [0,0,0]
    end
    
    it 'should skip sentiments that are nil' do
      tweet = FactoryGirl.create(:tweet, sentiment: nil)
      analysis = Analysis.create
      expect{analysis.populate_analysis}.not_to raise_error
    end
  end
end
