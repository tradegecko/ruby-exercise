class Dialogue

  # This method creates a response to a given text (the reserved space is for an eventual username)
  def self.respond_to(question, reserved_space = 0)
    begin
      response = Unirest.post(
          Rails.application.config.dialogue_api.url,
          parameters: {
              :appid => Rails.application.secrets.dialogue_api_key,
              :format => 'plaintext',
              :input => question
          }
      )
    rescue Timeout::Error
      warn 'Dialogue API timed out...'
      return "Uhm, I'm afraid I don't know..."
    end

    # answer body (should) look like this : http://products.wolframalpha.com/api/explorer.html

    if response.code == 200
      response_hash = Hash.from_xml(response.body.gsub("\n", ''))

      if response_hash['queryresult']['success'] == 'true'
        message = "#{response_hash['queryresult']['pod'][1]['subpod']['plaintext']} - http://www.wolframalpha.com"

        if message.length > Rails.application.config.tweet.default_length - reserved_space
          return '"I have discovered a truly remarkable proof which this margin is too small to contain." Try http://www.wolframalpha.com'
        else
          return message
        end
      else
        return "Uhm, I'm afraid I don't know..."
      end
    end

    warn "Issue with the response api : http response code #{response.code}"
  end
end
