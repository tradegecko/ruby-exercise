class RobotsController < ApplicationController
  def index
    render json: Flickr.search(params["category"])
  end
end
