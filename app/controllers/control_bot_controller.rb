require 'twitter_api_helper'

class ControlBotController < ApplicationController
  def reply
   @mention = TwitterApiHelper.answerToMentions
  end
end
