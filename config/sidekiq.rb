logger.info("Redis Provider: #{ENV["REDIS_PROVIDER"]}" )

Sidekiq.configure_server do |config|
  config.redis = {
    url: ENV["REDIS_PROVIDER"]
  }
end

unless Rails.env.production?
  Sidekiq.configure_client do |config|
    config.redis = {
      url: ENV["REDIS_PROVIDER"]
    }
  end
end
