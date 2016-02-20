require 'http'
require 'json'

class Translator
  attr_reader :supported_langs, :supported_lang_codes, :supported_langs_hash

  def initialize()
    all_langs = YandexLanguage.all;
    @supported_langs = all_langs
    @supported_langs_hash = all_langs.map { |l| [l.code, l.language] }
    @supported_lang_codes = Hash[all_langs.map { |l| [l.code, l.language] }].keys
  end


  #TODO To move these into env-specific files. Dev keys only.
  #Constant keys
  API_KEY_YANDEX = "trnsl.1.1.20160220T002124Z.6611cfab5a9c31ae.94d42334594d99371e8b5ee8ce6c75b61c1b5122"
  YANDEX_ENDPOINT = "https://translate.yandex.net/api/v1.5/tr.json/translate"
  YANDEX_TRANSLATE_CODE_KEY = "code"
  YANDEX_TRANSLATE_TEXT_KEY = "text"
  YANDEX_TRANSLATE_MESSAGE_KEY_KEY = "message"


  # Translate to a specific language using Yandex
  # Params:
  # +text+:: body of tweet to be translated
  # +lang+:: language to be translated to (for simplicity, original language is auto-detected by Yandex)
  # @return translated message if successful or false
  def translate_with_yandex (text, lang)
    params_str = "?key=#{API_KEY_YANDEX}&text='#{text}'&lang=#{lang}"
    translate_uri = YANDEX_ENDPOINT + params_str

    # get translation
    begin
      response_str = HTTP.get(translate_uri).to_s
    rescue StandardError => e
      return RequestStatus.new(true, e.message)
    end

    response_hash = JSON.parse(response_str)

    if response_hash[YANDEX_TRANSLATE_CODE_KEY] == 200
      RequestStatus.new(true, response_hash[YANDEX_TRANSLATE_TEXT_KEY][0])
    else
      RequestStatus.new(false, response_hash[YANDEX_TRANSLATE_MESSAGE_KEY_KEY])
    end
  end

  def is_supported_language_by_code?(code)
    @supported_lang_codes.include? code
  end
end