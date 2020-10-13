# frozen_string_literal: true

require 'coveralls'
Coveralls.wear!

require 'bundler/setup'
require 'em-http' # As of webmock 1.4.0, em-http must be loaded first
require 'multi_json'
require 'webmock/rspec'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run(:focus)

  config.expect_with(:rspec) do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with(:rspec) do |mocks|
    mocks.syntax = :expect
  end

  config.order = :random

  config.before(:each) do
    WebMock.reset!
    WebMock.disable_net_connect!
  end
end
