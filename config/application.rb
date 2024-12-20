require_relative "boot"

require "rails/all"
require "active_storage/engine"


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Group4LunieDatingAppFinalSubmission
  class Application < Rails::Application
    config.active_job.queue_adapter = :sidekiq
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Cấu hình autoload và eager load
    config.autoload_paths += %W(#{config.root}/app/models)
    config.eager_load_paths += %W(#{config.root}/app/models)
    config.autoload_paths += %W(#{config.root}/app/models/concerns)
    config.eager_load_paths += %W(#{config.root}/app/models/concerns)
    
    # Active Storage configuration
    config.active_storage.service = :local
    
    # Đảm bảo ApplicationRecord được load trước
    require_relative '../app/models/application_record'

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.hosts << "library-app-production-5dbc.up.railway.app"

    # Thêm dòng này để tắt web console và thông số ping
    config.middleware.delete Rails::Rack::Logger
    config.filter_parameters += [:password, :password_confirmation]
    
    # Disable Rails logging to stdout in development
    config.logger = ActiveSupport::Logger.new(nil) if Rails.env.development?

    # Thêm dòng này để load tất cả helpers
    config.autoload_paths += %W(#{config.root}/app/helpers)
  end
end
