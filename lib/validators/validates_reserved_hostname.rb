# frozen_string_literal: true

module ActiveModel
  module Validations
    class ReservedHostnameValidator < EachValidator
      def validate_each(record, attribute, value)
        return if value.blank? && options[:allow_blank]
        return if value.nil? && options[:allow_nil]
        return unless reserved?(value.to_s)

        record.errors.add(
          attribute,
          :"reserved_#{options[:error_name]}",
          message: options[:message],
          value: value
        )
      end

      def reserved?(subdomain)
        ::Validators::ReservedHostnames.reserved?(subdomain, options[:in])
      end
    end

    module ClassMethods
      # Validates whether or not the specified hostname is valid.
      # The `in: array` can have strings and patterns. A pattern is everything
      # that starts with `/` and will be parsed as a regular expression.
      #
      # Notice that subdomains will be normalized; it'll be downcased and have
      # its underscores and hyphens stripped.
      #
      #   class User < ActiveRecord::Base
      #     validates_reserved_hostname :site
      #
      #     # Validates against a custom list.
      #     validates_reserved_hostname :site, in: %w[www]
      #   end
      #
      def validates_reserved_hostname(*attr_names)
        options = _merge_attributes(attr_names).merge(error_name: :hostname)
        validates_with ReservedHostnameValidator, options
      end
    end
  end
end
