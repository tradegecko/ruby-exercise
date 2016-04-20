class Flickr
  # class for searching photos in Flickr API and return a single random
  # picture with short url, title, photo url and owner.

  # Search method.
  # Step 1: Find the total number of results for the search.
  # Step 2: Redo the search with a random page number within the total pages count.
  def self.search(category)
    Rails.logger.debug "New Flickr search with #{category}"
    all_photos = api_search(category, 1)
    pages = all_photos["pages"].to_i
    if pages == 0
      Rails.logger.fatal "No photos in the result for #{category}"
      raise "No photos found"
    end

    photos = api_search(category, rand(1...pages))
    photos = all_photos if photos["photo"].nil? # revert to original set if the new response doesnt have photos.
    # throw error if there are no photos in the response at all.
    if photos["photo"].nil?
      Rails.logger.fatal "No photo attr in the response field for #{category}"
      raise "Photos missing in response"
    end
    photo = photos["photo"][rand(0...photos["photo"].length)]
    {
      title: photo["title"],
      flickr_url: url_short(photo),
      photo_url: photo_url(photo),
      owner: photo["ownername"]
    }
  end

  private
  def self.api_search(category, page_number)
    options = {
      api_key: Rails.application.secrets.FLICKR_API_KEY, method: "flickr.photos.search",
      tags: category, tags_mode: "all", safe_mode: 1,
      page: page_number, extras: "owner_name"
    }

    # HTTPClient has a default timeout of 60 sec after with a timeout error is raised.
    response = HTTPClient.get("https://api.flickr.com/services/rest", options)
    if(response.status_code != 200)
      Rails.logger.fatal "API failure. #{response.attrs}"
      raise "Unknown error"
    end
    result = Crack::XML.parse(response.body)

    if result["rsp"]["err"]
      Rails.logger.fatal "API failure. #{result}"
      raise "Unknown error"
    end
    result["rsp"]["photos"]
  end

  # src: https://github.com/hanklords/flickraw/blob/master/lib/flickraw/api.rb
  BASE58_ALPHABET="123456789abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ".freeze
  URL_SHORT='https://flic.kr/p/'.freeze
  PHOTO_SOURCE_URL='https://farm%s.staticflickr.com/%s/%s_%s%s.%s'.freeze

  def self.base58(id)
    id = id.to_i
    alphabet = BASE58_ALPHABET.split(//)
    base = alphabet.length
    begin
      id, m = id.divmod(base)
      r = alphabet[m] + (r || '')
    end while id > 0
    r
  end

  # Ref: https://www.flickr.com/services/api/misc.urls.html
  def self.url_short(photo)
    URL_SHORT + base58(photo["id"])
  end

  # Ref: https://www.flickr.com/services/api/misc.urls.html
  def self.photo_url(photo)
    PHOTO_SOURCE_URL % [photo["farm"], photo["server"], photo["id"], photo["secret"], "",   "jpg"]
  end
end
