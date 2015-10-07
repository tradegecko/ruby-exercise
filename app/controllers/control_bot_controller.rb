require 'twitter_api_helper'

class ControlBotController < ApplicationController
  def reply
   @mention = TwitterApiHelper.answerToMentions.gsub(/\n/, '<br />').html_safe
  end
end
