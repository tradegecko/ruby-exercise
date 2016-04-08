module ApplicationHelper
	def request_ip
  	if Rails.env.development?
      return 'Singapore'
    else
      request.location.city
    end 
  end
end
