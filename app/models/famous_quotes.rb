class FamousQuotes

  # This method tweets a random quote
  def self.get_one
    message = ''


    begin
      response = Unirest.post Rails.application.config.quote_api.url,
                              headers: Rails.application.config.quote_api.headers
    rescue Timeout::Error
      warn 'FamousQuotes API timed out...'
      return nil
    end

    if response.code == 200
      message = "#{response.body['quote']} - #{response.body['author']}"

      while message.length > Rails.application.config.tweet.default_length and response.code == 200
        response = Unirest.post Rails.application.config.quote_api.url,
                                headers: Rails.application.config.quote_api.headers

        if response.code == 200
          message = "#{response.body['quote']} - #{response.body['author']}"
        end
      end
    end

    if response.code != 200
      warn "Issue with the quote api : http response code #{response.code}"
      return nil
    end

    message
  end
end
