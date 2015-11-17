require 'open-uri'
require 'securerandom'

class HttpHelper
  def self.download_file(url)
    open(temporary_file_name, 'wb') do |file|
      file << open(url).read
    end
  end

  private
  def self.temporary_file_name
    "tmp/#{SecureRandom.hex}"
  end
end