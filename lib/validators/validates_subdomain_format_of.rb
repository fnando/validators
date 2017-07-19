module ActiveModel
  module Validations
    class SubdomainValidator < EachValidator
      # Rules taken from http://www.zytrax.com/books/dns/apa/names.html
      def validate_each(record, attribute, value)
        return if value.blank? && options[:allow_blank]
        return if value.nil? && options[:allow_nil]
        return if valid_label?(value.to_s)

        record.errors.add(attribute, :invalid_subdomain,
          message: options[:message],
          value: value
        )
      end

      def valid_label?(label)
        !label.start_with?("-") &&
        !label.match(/\A\d+\z/) &&
        label.match(/\A[a-z0-9-]{1,63}\z/i)
      end
    end

    module ClassMethods
      # Validates whether or not the specified URL is valid.
      #
      #   class User < ActiveRecord::Base
      #     validates_subdomain_format_of :subdomain
      #     validates_subdomain :subdomain
      #   end
      #
      def validates_subdomain_format_of(*attr_names)
        validates_with SubdomainValidator, _merge_attributes(attr_names)
      end

      alias_method :validates_subdomain, :validates_subdomain_format_of
    end
  end
end
