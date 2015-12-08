require 'http_helper'

class TheGameGalApi
  URL='https://www.thegamegal.com/wordgenerator/generator.php?game=2&category=8'
  SAMPLE_SIZE=2

  def self.fetch_random_words
    pick_sample_words(HttpHelper.get_json(URL))
  end

  def self.pick_sample_words(data)
    data['words'].sample(SAMPLE_SIZE) if data['success']
  end
end