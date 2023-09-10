# frozen_string_literal: true

require "spec_helper"

RSpec.describe(OkComputer::PusherCheck) do
  subject(:check) { described_class.new(client: client) }

  let(:client) do
    Pusher::Client.new({
      app_id: "20",
      key: "12345678900000001",
      secret: "12345678900000001",
      host: "api.pusherapp.com",
      port: 80,
    })
  end
  let(:response) { { status: 200, body: MultiJson.encode({}) } }

  before { stub_request(:get, %r{/apps/20/channels}).to_return(response) }

  context("when successful") do
    let(:response) do
      {
        status: 200,
        body: MultiJson.encode(channels: { channel1: {}, channel2: {} }),
      }
    end

    it { is_expected.to(be_successful_check) }
    it { is_expected.to(have_message("Channels check successful")) }

    context("when not client") do
      subject(:check) do
        described_class.new(
          app_id: "20",
          app_key: "12345678900000001",
          app_secret: "12345678900000001",
        )
      end

      it { is_expected.to(be_successful_check) }
    end
  end

  context("when 401 fails") do
    let(:response) { { status: 401, body: MultiJson.encode({}) } }

    it { is_expected.not_to(be_successful_check) }
    it { is_expected.to(have_message("Error: '{}'")) }
  end

  context("when 403 fails") do
    let(:response) { { status: 403, body: MultiJson.encode({}) } }

    it { is_expected.not_to(be_successful_check) }
    it { is_expected.to(have_message("Error: 'Unknown error (status code 403): {}'")) }
  end
end
