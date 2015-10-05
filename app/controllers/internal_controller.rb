class InternalController < ApplicationController
  def status 
	  render text: 'bot is alive', content_type: 'text/plain'
  end
end
