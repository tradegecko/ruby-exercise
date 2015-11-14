Airbrake.configure do |config|
  config.api_key = Rails.application.secrets.airbrake_api_key
  config.host    = Rails.application.secrets.airbrake_host
  config.port    = Rails.application.secrets.airbrake_port
  config.secure  = config.port.to_s == '443'
end if defined?(Airbrake) && Rails.env.production?
