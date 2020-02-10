# frozen_string_literal: true

module ActiveModel
  module Validations
    class SubdomainValidator < EachValidator
      def validate_each(record, attribute, value)
        return if value.blank? && options[:allow_blank]
        return if value.nil? && options[:allow_nil]

        value = value.to_s

        validate_reserved_subdomain(record, attribute, value)
        validate_format(record, attribute, value)
      end

      def reserved?(subdomain)
        ::Validators::ReservedSubdomains.reserved?(subdomain, options[:in])
      end

      def validate_reserved_subdomain(record, attribute, value)
        return unless options.fetch(:reserved, true)
        return unless reserved?(value)

        record.errors.add(
          attribute,
          :"reserved_#{options[:error_name]}",
          message: options[:message],
          value: value
        )
      end

      def validate_format(record, attribute, value)
        return if Validators::Hostname.valid_label?(value)

        record.errors.add(
          attribute,
          :"invalid_#{options[:error_name]}",
          message: options[:message],
          value: value
        )
      end
    end

    module ClassMethods
      # Validates whether or not the specified host label is valid.
      # The `in: array` can have strings and patterns. A pattern is everything
      # that starts with `/` and will be parsed as a regular expression.
      #
      # Notice that subdomains will be normalized; it'll be downcased and have
      # its underscores and hyphens stripped before validating.
      #
      #   class User < ActiveRecord::Base
      #     # Validates format and rejects reserved subdomains.
      #     validates_subdomain :subdomain
      #
      #     # Validates against a custom list.
      #     validates_subdomain :subdomain, in: %w[www]
      #
      #     # Rejects reserved domains validation.
      #     validates_subdomain :subdomain, reserved: false
      #   end
      #
      def validates_subdomain(*attr_names)
        options = _merge_attributes(attr_names).merge(error_name: :subdomain)
        validates_with SubdomainValidator, options
      end
    end
  end
end
