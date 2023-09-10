# frozen_string_literal: true

require "spec_helper"

RSpec.describe(OkComputer::AlgoliaCheck) do
  subject(:check) { described_class.new(app_id: app_id, api_key: api_key) }

  let(:app_id) { "APPID" }
  let(:api_key) { "apikey" }
  let(:response) { { status: 200, body: MultiJson.encode({}) } }

  before { stub_request(:get, %r{/1/status}).to_return(response) }

  context("when successful") do
    let(:response) do
      {
        status: 200,
        body: MultiJson.encode(status: { "c4-fr" => "operational", "c2-eu" => "operational" }),
      }
    end

    it { is_expected.to(be_successful_check) }
    it { is_expected.to(have_message("Monitoring check successful")) }
  end

  context("when 401 fails") do
    let(:response) do
      {
        status: 401,
        body: MultiJson.encode(message: "Invalid Application-Id or API-Key"),
      }
    end

    it { is_expected.not_to(be_successful_check) }
    it { is_expected.to(have_message("Error: '{\"message\"=>\"Invalid Application-Id or API-Key\"}'")) }
  end

  context("when not operational") do
    let(:response) do
      {
        status: 200,
        body: MultiJson.encode(status: { "c4-fr" => "degraded_performance", "c2-eu" => "major_outage" }),
      }
    end

    it { is_expected.not_to(be_successful_check) }
  end
end
