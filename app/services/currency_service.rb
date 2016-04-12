class CurrencyService

  def initialize(converted_currency)
    @converted_currency = converted_currency
  end

  def get_currency
    uri.query = URI.encode_www_form(params)
    response  = Net::HTTP.get_response(uri)

    parsed_response = ActiveSupport::JSON.decode(response.body)
    parsed_response['quotes']
  end

  private
  def uri
    @uri ||= URI.parse("http://apilayer.net/api/live")
  end

  def params
    { access_key: ENV["CURRENCY_LAYER_ACCESS_TOKEN"], currencies: @converted_currency }
  end
end

