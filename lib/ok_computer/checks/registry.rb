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

      def add_collection(collection_name, &block)
        checks = CheckCollection.new(collection_name)
        Checks.register(checks, &block)
        register(collection_name, checks)
      end

      def add_optional(klass_or_check, check_name, *args)
        add(OptionalCheck.new(process_check(klass_or_check, *args)), check_name)
      end

      def add(klass_or_check, check_name, *args)
        register(check_name, process_check(klass_or_check, *args))
      end

      private

      def process_check(klass_or_check, *args)
        return klass_or_check if [OptionalCheck, Check, CheckCollection].any? { |k| klass_or_check.is_a?(k) }

        build_check(klass_or_check, *args)
      end

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
