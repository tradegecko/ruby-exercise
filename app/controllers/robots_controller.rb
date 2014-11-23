class RobotsController < ApplicationController
  def index
    
  end

  def run
  	@tweets = Bot.run_bot
  end
end
