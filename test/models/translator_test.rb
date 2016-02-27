require 'test_helper'

class TranslatorTest < ActiveSupport::TestCase

  test "translation" do
    response = Translator.new.translate_with_yandex("Let's have a party with Angular tomorrow?", 'zh')
    # puts response
    assert(response.status, response.message)
  end

end