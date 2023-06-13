# frozen_string_literal: true

require_relative "boot"
require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Workspace
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # タイムゾーンを東京に設定する
    config.time_zone = "Tokyo"
    config.active_record.default_timezone = :local

    # config.eager_load_paths << Rails.root.join("extras")
    config.i18n.load_path += Dir[Rails.root.join("config", "locales", "**", "*.{rb,yml}").to_s]
    config.autoload_paths += Dir.glob("#{config.root}/lib")
    config.i18n.default_locale = :ja

    # MEMO: ルーティングの読み込み順番を定義している
    config.paths["config/routes.rb"] = Dir[Rails.root.join("config/routes/**/*.rb"), "config/routes.rb"]

    # routes.rbを分割しない場合は
    # config.paths["config/routes.rb"] = Dir["config/routes.rb"]
  end
end
