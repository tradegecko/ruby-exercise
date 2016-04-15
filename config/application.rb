require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RubyExercise
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.FLICKR_API_KEY           = "f90aaa0af048900362f6138e23a81084"
    config.TWITTER_CONSUMER_KEY     = "4JQpFiyavYMq8a4sIV5KcG5Tu"
    config.TWITTER_CONSUMER_SECRET  = ENV["TWITTER_CONSUMER_SECRET"]
    config.TWITTER_ACCESS_TOKEN     = "720881202295496704-a4Qp9Wb7VirZxUtOOn2UySOgwFHaI8M"
    config.TWITTER_ACCESS_SECRET    = ENV["TWITTER_ACCESS_SECRET"]
  end
end
