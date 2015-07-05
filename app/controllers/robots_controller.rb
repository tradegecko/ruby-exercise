class RobotsController < ApplicationController
  before_action :fetch_startup, only: [:find_similar]

  def index
    render json: {
      status: "This is just a bot"
    }
  end
end
