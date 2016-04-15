class FindController < ApplicationController

  def create
    begin
      render json: Flickr.search(params["category"])
    rescue
      render json: {oops: "No photo. Here's a potato."}
    end
  end
end
