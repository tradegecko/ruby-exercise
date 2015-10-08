require 'twitter_api_helper'

class ControlBotController < ApplicationController
  def reply
   @mention = TwitterApiHelper.answer_to_mentions
  end
end
