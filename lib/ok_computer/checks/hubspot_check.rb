# frozen_string_literal: true

require 'faraday'
require 'ok_computer/built_in_checks/http_check'

module OkComputer
  class HubspotCheck < HttpCheck
    StatusFailed = Class.new(StandardError)

    STATUS_URL = 'https://api.hubapi.com/integrations/v1/limit/daily'

    attr_accessor :api_key

    def initialize(url: STATUS_URL, api_key: nil, request_timeout: 5)
      super(url, request_timeout)

      self.api_key = api_key.presence
    end

    # Public: Return the status of the Rate-Limit check
    def check
      status, body = perform_request
      raise(StatusFailed, body) unless status == 200

      mark_message('Rate-Limit check successful')
    rescue StandardError => e
      mark_message("Error: '#{e}'")
      mark_failure
    end

    def perform_request
      response = Faraday.get(url, request: { timeout: request_timeout }) do |req|
        req.headers['Content-Type'] = 'application/json'
        req.body = { hapikey: api_key }.to_json
      end

      [response.status, MultiJson.decode(response.body)]
    rescue StandardError => e
      raise(StatusFailed, e)
    end
  end
end
