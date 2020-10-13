# frozen_string_literal: true

require 'rails_helper'
require 'ok_computer/checks/nexmo_check'

RSpec.describe(OkComputer::NexmoCheck) do
  let(:api_key) { 'nexmo-api-key' }
  let(:api_secret) { 'nexmo-api-secret' }
  let(:signature_secret) { 'nexmo-signature-secret' }
  let(:client) do
    Nexmo::Client.new(
      api_key: api_key,
      api_secret: api_secret,
      signature_secret: signature_secret
    )
  end
  let(:headers) { { 'Content-Type' => 'application/json;charset=utf-8' } }
  let(:response) { { status: 200, body: MultiJson.encode({}), headers: headers } }

  subject(:check) { described_class.new(client: client) }

  before { stub_request(:get, %r{/account/get-balance}).to_return(response) }

  context('when successful') do
    let(:response) do
      {
        status: 200,
        body: MultiJson.encode(value: 10.28, autoReload: false),
        headers: headers,
      }
    end

    it { is_expected.to(be_successful_check) }
    it { is_expected.to(have_message('Balance 10.28 check successful')) }

    context('when not client') do
      subject(:check) do
        described_class.new(
          api_key: api_key,
          api_secret: api_secret,
          signature_secret: signature_secret
        )
      end

      it { is_expected.to(be_successful_check) }
    end
  end

  context('when 401 fails') do
    let(:response) { { status: 401, body: MultiJson.encode({}), headers: headers } }

    it { is_expected.not_to(be_successful_check) }
    it { is_expected.to(have_message("Error: 'Nexmo::AuthenticationError'")) }
  end
end
