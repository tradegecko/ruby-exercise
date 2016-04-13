require 'test_helper'

class DialogueTest < ActionController::TestCase
  context 'Check famous quote API up and still compliant' do
    should 'have a response body properly formatted' do
      response = Unirest.post Rails.application.config.quote_api.url,
                              headers: Rails.application.config.quote_api.headers
      assert_response :ok

      assert response.body['quote']
      assert response.body['author']
    end

    should 'return a quote' do
      assert_not_equal 0, FamousQuotes.get_one.to_s.strip.length
    end
  end
end
