class Flickr

  def self.search(category)
    all_photos = api_search(category, 1)
    pages = all_photos["pages"].to_i
    raise "No photos found" if pages == 0

    photos = api_search(category, rand(1...pages))

    raise "Photos missing in response" if photos["photo"].nil?
    photo = photos["photo"][rand(0...photos["photo"].length)]
    {
      title: photo["title"],
      flickr_photo: url_short(photo),
      owner: photo["ownername"]
    }
  end

  private
  def self.api_search(category, page_number)
    options = {
      api_key: Rails.configuration.FLICKR_API_KEY, method: "flickr.photos.search",
      tags: category, tags_mode: "all", safe_mode: 1,
      page: page_number, extras: "owner_name"
    }

    response = HTTPClient.get("https://api.flickr.com/services/rest", options)
    raise "Unknown error" if(response.status_code != 200)
    results = Crack::XML.parse(response.body)

    raise "Unknown error" if results["rsp"]["err"]
    results["rsp"]["photos"]
  end

  # src: https://github.com/hanklords/flickraw/blob/master/lib/flickraw/api.rb
  BASE58_ALPHABET="123456789abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ".freeze
  URL_SHORT='https://flic.kr/p/'.freeze

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

  def self.url_short(r)
    URL_SHORT + base58(r["id"])
  end
end
