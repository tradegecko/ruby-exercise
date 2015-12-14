uri = ENV["REDISTOGO_URL"] || "redis://localhost:6379/"

Sidekiq.configure_server do |config|
  config.redis = { url: uri }
end

Sidekiq.configure_client do |config|
  config.redis = { url: uri }
end
