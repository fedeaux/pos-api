require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ApiPos
  class Application < Rails::Application
    config.autoload_paths += Dir["#{Rails.root}/lib/include/**/"]

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*',
          headers: :any,
          methods: :any,
          expose: ['access-token', 'expiry', 'token-type', 'uid', 'client']
      end
    end
  end
end
