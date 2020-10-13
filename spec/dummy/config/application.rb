require File.expand_path('boot', __dir__)

require 'rails/all'

Bundler.require
require 'okcomputer'

module Dummy
  class Application < Rails::Application
    config.encoding = 'utf-8'
    config.filter_parameters += [:password]
    config.active_support.escape_html_entities_in_json = true
    config.assets.enabled = false
    config.secret_key_base = '78987c1cc6dc799c6baf50cadf73700ae861e5d81d28b2ec702b6e168d0cf3c8ad7be699f1d0f98e5b2b563ca70d9516b9c2a66184de39516c09a19aa2d96817'
    config.session_store(:cookie_store, key: '_dummy_session')
    config.cache_classes = true
    config.consider_all_requests_local       = true
    config.action_controller.perform_caching = false
    config.action_dispatch.show_exceptions = false
    config.action_controller.allow_forgery_protection = false
    config.action_mailer.delivery_method = :test
    config.active_support.deprecation = :stderr
    config.eager_load = false
  end
end
