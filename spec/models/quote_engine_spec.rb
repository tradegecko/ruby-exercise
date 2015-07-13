require 'rails_helper'

RSpec.describe QuoteEngine, type: :model do
  it "should test 'random' with a valid quote" do
    allow(Unirest).to receive(:post) { OpenStruct.new(:code => 200, :body => {"quote" => "A thing of beauty is a joy forever"}) }
    quote = QuoteEngine.random
    expect(quote.text).to eq "A thing of beauty is a joy forever"
  end

  it "should test 'random' with an invalid quote" do
    allow(Unirest).to receive(:post) { OpenStruct.new(:code => 403) }
    quote = QuoteEngine.random
    expect(quote.text).to eq "Seems like I am out of any new quotes"
  end
end
