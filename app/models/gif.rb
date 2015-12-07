require 'giphy_api'
require 'http_helper'

class Gif < ActiveRecord::Base
  validates_presence_of :url, message: 'No gif found on Giphy server'
  validates :url, uniqueness: {
      message: 'Gif already tweeted',
      case_sensitive: false,
  }

  has_one :tweet

  def self.get_random_gif(keyword)
    Gif.create!(
      keyword: keyword,
      url: GiphyApi.new.fetch_random_gif(keyword).to_s
    )
  rescue ActiveRecord::RecordInvalid => errors
    puts errors.to_s
    return nil
  end

  def file
    @file ||= File.new(HttpHelper.download_file(self.url).path)
  end
end
