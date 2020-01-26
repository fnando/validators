# frozen_string_literal: true

module ActiveModel
  module Validations
    class ReservedUsernameValidator < ReservedHostnameValidator
    end

    module ClassMethods
      # Validates whether or not the specified username is valid.
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
      def validates_reserved_username(*attr_names)
        options = _merge_attributes(attr_names).merge(error_name: :username)
        validates_with ReservedHostnameValidator, options
      end
    end
  end
end
