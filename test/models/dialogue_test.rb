require 'test_helper'

class DialogueTest < ActionController::TestCase
  context 'Check dialogue API up and still compliant' do
    should 'respond with http code 200' do
      Unirest.post(
          Rails.application.config.dialogue_api.url,
          parameters: {
              :appid => Rails.application.secrets.dialogue_api_key,
              :format => 'plaintext',
              :input => 'hello'
          }
      )
      assert_response :ok
    end

    should 'have a response body properly formatted' do
      response = Unirest.post(
          Rails.application.config.dialogue_api.url,
          parameters: {
              :appid => Rails.application.secrets.dialogue_api_key,
              :format => 'plaintext',
              :input => 'hello'
          }
      )
      assert_response :ok
      response_hash = Hash.from_xml(response.body.gsub("\n", ''))
      assert_equal 'true', response_hash['queryresult']['success']
      assert response_hash['queryresult']['pod'][1]['subpod']['plaintext']
    end

    should 'answer unknown if the api does not return an answer' do
      assert_equal "Uhm, I'm afraid I don't know...", Dialogue.respond_to('azergerbrznsrnyetntynbetnhtehntenzefgerhrz')
    end
  end
end
