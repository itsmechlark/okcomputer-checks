# frozen_string_literal: true

require 'active_support/core_ext/module/delegation'

require 'ok_computer/check_collection'
require 'ok_computer/registry'

module OkComputer
  # :nodoc:
  module Checks
    class Registry < ::OkComputer::Registry
      attr_accessor :collection

      delegate_missing_to :collection

      def initialize(collection = nil)
        self.collection = if collection.is_a?(CheckCollection)
          collection
        elsif collection
          ::OkComputer::Registry.default_collection.fetch(collection) || CheckCollection.new(collection)
        else
          ::OkComputer::Registry.default_collection
        end
      end

      def add(klass_or_check, check_name, *args)
        check = if klass_or_check.is_a?(CheckCollection) || klass_or_check.is_a?(Check)
          klass_or_check
        else
          build_check(klass_or_check, *args)
        end

        collection.register(check_name, check)
      end

      private

      def build_check(klass, *args)
        unless klass.is_a?(Class)
          begin
            klass = OkComputer.const_get("#{klass}_check".camelize)
          rescue NameError
            raise LoadError, "Could not register #{klass.inspect}."
          end
        end
        klass.new(*args)
      end
    end
  end
end
