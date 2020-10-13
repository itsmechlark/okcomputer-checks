# frozen_string_literal: true

require 'active_support/dependencies/autoload'

require 'ok_computer/check'
require 'ok_computer/checks/registry'

module OkComputer
  extend ActiveSupport::Autoload

  autoload :AlgoliaCheck, 'ok_computer/checks/algolia_check'
  autoload :HubspotCheck, 'ok_computer/checks/hubspot_check'
  autoload :NexmoCheck, 'ok_computer/checks/nexmo_check'
  autoload :PusherCheck, 'ok_computer/checks/pusher_check'

  # :nodoc:
  module Checks
    def self.register(collection = nil)
      registry = Registry.new(collection)
      yield registry if block_given?
      registry
    end
  end
end
