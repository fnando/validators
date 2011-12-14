module ActiveModel
  module Validations
    class UrlValidator < EachValidator
      def validate_each(record, attribute, value)
        if value.to_s !~ Validators::URL_FORMAT
          record.errors.add(
            attribute, :invalid_url,
            :message => options[:message], :value => value
          )
        end
      end
    end

    module ClassMethods
      # Validates whether or not the specified URL is valid.
      #
      #   class User < ActiveRecord::Base
      #     validates_url_format_of :site
      #   end
      #
      def validates_url_format_of(*attr_names)
        validates_with UrlValidator, _merge_attributes(attr_names)
      end

      alias_method :validates_url, :validates_url_format_of
    end
  end
end
