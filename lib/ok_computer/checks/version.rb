# frozen_string_literal: true

module OkComputer
  module Checks
    VERSION = "1.1.1"

    class << self
      def gem_version
        Gem::Version.new(VERSION)
      end
    end
  end
end
