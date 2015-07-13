class QuoteEngine
  QUOTES_API_URL = "https://andruxnet-random-famous-quotes.p.mashape.com/cat=random"
  def self.random
    response = Unirest.post QUOTES_API_URL, headers: headers
    return Quote.new(response.body) if response.code == 200
    return Quote.new(:text => "Seems like I am out of any new quotes", :author => 'GeckoBot', :category => 'Wrong')
  end

  private

  def self.headers
    {
      "X-Mashape-Key" => ENV['MASHAPE_KEY'],
      "Content-Type" => "application/x-www-form-urlencoded",
      "Accept" => "application/json"
    }
  end
end
