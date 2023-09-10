# frozen_string_literal: true

require "nexmo"

module OkComputer
  class NexmoCheck < Check
    AccountError = Class.new(StandardError)

    attr_accessor :client

    def initialize(client: nil, api_key: nil, api_secret: nil, signature_secret: nil)
      client ||= Nexmo::Client.new(
        api_key: api_key,
        api_secret: api_secret,
        signature_secret: signature_secret,
      )

      self.client = client
    end

    # Public: Return the status of the Account Balance check
    def check
      response = perform_request
      return mark_failure unless response.http_response.code.to_i == 200

      mark_message("Balance #{response.value} check successful")
    rescue StandardError => e
      mark_message("Error: '#{e}'")
      mark_failure
    end

    def perform_request
      client.account.balance
    rescue StandardError => e
      raise(AccountError, e)
    end
  end
end
