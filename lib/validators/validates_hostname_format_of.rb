module ActiveModel
  module Validations
    class HostnameValidator < EachValidator
      # Rules taken from http://www.zytrax.com/books/dns/apa/names.html
      def validate_each(record, attribute, value)
        return if value.blank? && options[:allow_blank]
        return if value.nil? && options[:allow_nil]
        return if valid_hostname?(value.to_s)

        record.errors.add(attribute, :invalid_hostname,
          :message => options[:message],
          :value => value
        )
      end

      def valid_hostname?(host)
        host = host.to_s
        uri = URI(host)

        host.present? &&
        uri.host.nil? &&
        uri.scheme.nil? &&
        uri.fragment.nil? &&
        uri.query.nil? &&
        uri.path == host &&
        host.split('.').all? {|label| valid_label?(label) } &&
        host.size <= 255 &&
        valid_tld?(host)
      rescue URI::InvalidURIError
        false
      end

      def valid_label?(label)
        !label.start_with?('-') &&
        !label.match(/\A\d+\z/) &&
        label.match(/\A[a-z0-9-]{1,63}\z/i)
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
