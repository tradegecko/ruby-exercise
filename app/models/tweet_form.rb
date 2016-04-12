class TweetForm
  include ActiveModel::Model

  attr_accessor :currency_id

  validates :currency_id, presence: true

  def create
    return false unless self.valid?
    create_tweet
  end

  private
  def create_tweet
    TwitterClient.update("Latest currency rate : 1 USD = #{rate} #{currency.code}")
    true
  rescue exception => e
    false
  end

  def rate
    rates.values.first
  end

  def rates
    @rates ||= CurrencyService.new(currency.code).get_currency
  end

  def currency
    @currency ||= Currency.find(currency_id)
  end
end

