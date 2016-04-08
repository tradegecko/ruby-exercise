require 'forecast_io'

ForecastIO.configure do |configuration|
	configuration.api_key = ENV['FORECASTIO_KEY']
end