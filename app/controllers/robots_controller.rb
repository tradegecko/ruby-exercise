class RobotsController < ApplicationController
  def index
    render json: {
      status: "This is just a bot"
    }
  end
end
