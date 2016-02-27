require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RubyExercise
  class Application < Rails::Application

    # load Models in models/subfolder
    config.autoload_paths += Dir[Rails.root.join('app', 'models', '{*/}')]

    PAGINATION_PAGE_DEFAULT = 5;
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # API keys best practices.
    def load_env_file(environment = nil)
      path = Rails.root.join("config", "env#{environment.nil? ? '' : '.'+environment}.yml")
      return unless File.exist? path
      config = YAML.load(ERB.new(File.new(path).read).result)
      config.each { |key, value| ENV[key.to_s] = value.to_s }
    end

    load_env_file

    load_env_file(Rails.env)

  end
end
