require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RubyExercise
  class Application < Rails::Application
    config.autoload_paths << File.join(Rails.root, "app", "classes")
    config.generators do |generate|
      generate.helper false
      generate.javascript_engine false
      generate.stylesheets false
      generate.request_specs false
      generate.routing_specs false
      generate.test_framework :rspec
      generate.view_specs false
    end     
  end
end
