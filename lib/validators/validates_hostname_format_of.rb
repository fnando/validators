# frozen_string_literal: true

module ActiveModel
  module Validations
    class HostnameValidator < EachValidator
      # Rules taken from http://www.zytrax.com/books/dns/apa/names.html
      def validate_each(record, attribute, value)
        return if value.blank? && options[:allow_blank]
        return if value.nil? && options[:allow_nil]
        return if Validators::Hostname.valid?(value.to_s)

        record.errors.add(
          attribute,
          :invalid_hostname,
          message: options[:message],
          value: value
        )
      end
    end

    module ClassMethods
      # Validates whether or not the specified URL is valid.
      #
      #   class User < ActiveRecord::Base
      #     validates_hostname_format_of :site
      #
      #     # Validates against a list of valid TLD.
      #     validates_hostname_format_of :site, tld: true
      #   end
      #
      def validates_hostname_format_of(*attr_names)
        validates_with HostnameValidator, _merge_attributes(attr_names)
      end

      alias_method :validates_hostname, :validates_hostname_format_of
    end
  end
end
