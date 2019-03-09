# frozen_string_literal: true

module ActiveModel
  module Validations
    class UrlValidator < EachValidator
      def validate_each(record, attribute, value)
        return if value.blank? && options[:allow_blank]
        return if value.nil? && options[:allow_nil]
        return if url?(value.to_s)

        record.errors.add(
          attribute,
          :invalid_url,
          message: options[:message],
          value: value
        )
      end

      def url?(url)
        uri = URI(url)
        regex = if options[:tld]
                  Validators::URL_FORMAT_WITHOUT_TLD_VALIDATION
                else
                  Validators::URL_FORMAT
                end

        uri.is_a?(URI::HTTP) &&
          url.match(regex) &&
          valid_tld?(uri.host)
      rescue URI::InvalidURIError
        false
      end

      def valid_tld?(host)
        return true unless options[:tld]

        Validators::TLD.host_with_valid_tld?(host)
      end
    end

    module ClassMethods
      # Validates whether or not the specified URL is valid.
      #
      #   class User < ActiveRecord::Base
      #     validates_url_format_of :site
      #
      #     # Validates against a list of valid TLD.
      #     validates_url_format_of :site, tld: true
      #   end
      #
      def validates_url_format_of(*attr_names)
        validates_with UrlValidator, _merge_attributes(attr_names)
      end

      alias_method :validates_url, :validates_url_format_of
    end
  end
end
