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
      return I18n.t('dialogue.unknown')
    end

    # answer body (should) look like this : http://products.wolframalpha.com/api/explorer.html

    if response.code == 200
      response_hash = Hash.from_xml(response.body.gsub("\n", ''))

      if response_hash['queryresult']['success'] == 'true'
        message = "#{response_hash['queryresult']['pod'][1]['subpod']['plaintext']} - http://www.wolframalpha.com"

        if message.length > Rails.application.config.tweet.default_length - reserved_space
          return I18n.t('dialogue.too_long')
        else
          return message
        end
      else
        return I18n.t('dialogue.unknown')
      end
    end

    warn "Issue with the response api : http response code #{response.code}"
  end
end
