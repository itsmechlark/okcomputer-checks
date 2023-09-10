# frozen_string_literal: true

require "pusher"

module OkComputer
  class PusherCheck < Check
    ChannelError = Class.new(StandardError)

    attr_accessor :client

    def initialize(client: nil, app_id: nil, app_key: nil, app_secret: nil, app_cluster: nil) # rubocop:disable Lint/MissingSuper
      client ||= Pusher::Client.new(
        app_id: app_id,
        key: app_key,
        secret: app_secret,
        cluster: app_cluster,
        use_tls: true,
      )

      self.client = client
    end

    # Public: Return the status of the Channels check
    def check
      perform_request
      mark_message("Channels check successful")
    rescue StandardError => e
      mark_message("Error: '#{e}'")
      mark_failure
    end

    def perform_request
      client.get("/channels")
    rescue StandardError => e
      raise(ChannelError, e)
    end
  end
end
