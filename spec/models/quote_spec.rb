require 'rails_helper'

RSpec.describe Quote, type: :model do
  it "should initialize a quote properly" do
    quote = Quote.new :text => "A thing of beauty is joy forever", :author => "John Keats", :category => "Famous"
    expect(quote).to be_a(Quote)
    expect(quote.text).to eq "A thing of beauty is joy forever"
    expect(quote.author).to eq "John Keats"
    expect(quote.category).to eq "Famous"

    quote = Quote.new "text" => "A thing of beauty is joy forever string keys", "author" => "John Keats", "category" => "Famous"
    expect(quote).to be_a(Quote)
    expect(quote.text).to eq "A thing of beauty is joy forever string keys"
    expect(quote.author).to eq "John Keats"
    expect(quote.category).to eq "Famous"
  end
end
