require 'rubygems'
require 'net/http'
require 'uri'
require 'json'

module AlchemyAPI

  class DataInvalidError < StandardError; end
  class ServiceUnavailableError < StandardError; end

  BASE_URL = 'http://access.alchemyapi.com/calls'
  TEXT_SENTIMENT_ENDPOINT = '/text/TextGetTextSentiment'
  API_KEY = ENV['ALCHEMY_API_KEY']
  OUTPUT_MODE = 'json'

  def self.sentiment(data)
    raise DataInvalidError if data.nil? || data.strip.empty?
    analyze(data)
  end

  private

  def self.analyze(data)
    options = set_options(data) 
    request, uri = create_request_object(options)

    res = Net::HTTP.start(uri.host, uri.port) do |http|
      http.request(request)
    end

    JSON.parse(res.body)
  end

  def self.set_options(data)
    options = {
      'text' => data,
      'apikey' => API_KEY,
      'outputMode' => OUTPUT_MODE
    }
  end

  def self.create_request_object(options)
    url = BASE_URL + TEXT_SENTIMENT_ENDPOINT
    uri = URI.parse(url)
    request = Net::HTTP::Post.new(uri.request_uri)
    request.set_form_data(options)
    request['Accept-Encoding'] = 'identity'
    [request, uri]
  end

end
