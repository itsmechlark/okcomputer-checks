# frozen_string_literal: true

require "faraday"
require "ok_computer/built_in_checks/http_check"

module OkComputer
  class AlgoliaCheck < HttpCheck
    StatusFailed = Class.new(StandardError)

    STATUS_URL = "https://status.algolia.com/1/status"

    attr_accessor :app_id, :api_key

    def initialize(url: STATUS_URL, app_id: nil, api_key: nil, request_timeout: 5)
      super(url, request_timeout)

      self.app_id = app_id.presence
      self.api_key = api_key.presence
    end

    # Public: Return the status of the Monitoring check
    def check
      status, body = perform_request
      raise(StatusFailed, body) unless status == 200 && body["status"].values.all?("operational")

      mark_message("Monitoring check successful")
    rescue StandardError => e
      mark_message("Error: '#{e}'")
      mark_failure
    end

    def perform_request
      response = Faraday.get(url, request: { timeout: request_timeout }) do |req|
        req.headers["Content-Type"] = "application/json"
        req.headers["X-Algolia-API-Key"] = api_key
        req.headers["X-Algolia-Application-Id"] = app_id
      end

      [response.status, MultiJson.decode(response.body)]
    rescue StandardError => e
      raise(StatusFailed, e)
    end
  end
end
