class Gif
  def self.get_trending(limit = nil) #if no limit will get 25 due to the API
    url = "http://api.giphy.com/v1/gifs/trending?api_key=dc6zaTOxFJmzC"
    url << "&limit=" << limit.to_s unless limit
    response = HTTParty.get(url)
    if response.success?
      if response["data"].empty?
        false
      else
        limit ||= response["pagination"]["count"]
        response.parsed_response["data"][rand(0...limit)]["images"]["original"]["url"]
        #todo: save the id of the gif to prevent tweeting it again
      end
    else
      "Have a nice day everyone! Will post some gifs later 😊"
    end
  end

  def self.get(tag = nil)  #if no tag will get a random gif
    url = "http://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC"
    url << "&tag=" << tag.to_s if tag
    response = HTTParty.get(url)
    if response.success?
      if response["data"].empty?
    	  false
      else
        response.parsed_response["data"]["image_original_url"]
      end
    else
      "having some problems 😟 please try again later"
    end
  end
end