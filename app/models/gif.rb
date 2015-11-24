class Gif < ActiveRecord::Base
  validates_presence_of :url, message: 'No gif found on Giphy server'
  validates :url, uniqueness: {
      message: 'Gif already tweeted',
      case_sensitive: false,
  }

  has_one :tweet
  attr_accessor :tmp_file

  def self.get_random_gif(keyword)
    Gif.create!(
        keyword: keyword,
        url: GiphyApi.new.fetch_random_gif(keyword).to_s
    )
  end

  def file
    File.new(HttpHelper.download_file(self.url).path)
  end
end
