require 'test_helper'

class TranslatorTest < ActiveSupport::TestCase

  test "the successful" do
    response = Translator.new.translate_with_yandex('I love you', 'zh')
    puts response
    assert (response.status)
  end

  test "the failure" do
    response = Translator.new.translate_with_yandex('I love you', 'zhe')
    puts response
    assert (!response.status)
  end
end