# frozen_string_literal: true

require "spec_helper"

RSpec.describe(OkComputer::HubspotCheck) do
  subject(:check) { described_class.new(api_key: api_key) }

  let(:api_key) { "apikey" }
  let(:response) { { status: 200, body: MultiJson.encode({}) } }

  before { stub_request(:get, %r{/integrations/v1/limit/daily}).to_return(response) }

  context("when successful") do
    it { is_expected.to(be_successful_check) }
    it { is_expected.to(have_message("Rate-Limit check successful")) }
  end

  context("when 401 fails") do
    let(:response) { { status: 401, body: MultiJson.encode({}) } }

    it { is_expected.not_to(be_successful_check) }
    it { is_expected.to(have_message("Error: '{}'")) }
  end

  context("when rate-limit exceeded") do
    let(:response) do
      {
        status: 429,
        body: MultiJson.encode(status: "error"),
      }
    end

    it { is_expected.not_to(be_successful_check) }
  end
end
