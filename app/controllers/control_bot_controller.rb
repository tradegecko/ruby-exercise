require 'twitter_api_helper'

class ControlBotController < ApplicationController

  def view
    @result = TwitterApiHelper.getUserName
  end

  def reply
   @mention = TwitterApiHelper.answerToMentions 
  end
end
