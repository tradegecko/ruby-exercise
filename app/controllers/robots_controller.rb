class RobotsController < ApplicationController
  def index
  	@tweets = Bot.run_bot
  end
end
