require 'twitter_api'

class ControlBotController < ApplicationController
  def reply
    @mention = TwitterApi.new.answer_to_mentions
  end
end
