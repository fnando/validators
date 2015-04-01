module ActiveModel
  module Validations
    class UrlValidator < EachValidator
      TLD_FILE_PATH = File.expand_path('../../../data/tld.txt', __FILE__)

      def self.tlds
        @tld ||= File.read(TLD_FILE_PATH).lines.map(&:chomp)
      end

      def validate_each(record, attribute, value)
        return if url?(value.to_s)

        record.errors.add(attribute, :invalid_url,
          :message => options[:message],
          :value => value
        )
      end

      def url?(url)
        uri = URI(url)

        uri.kind_of?(URI::HTTP) &&
        url.match(Validators::URL_FORMAT) &&
        valid_tld?(uri.host)
      rescue URI::InvalidURIError
        false
      end

      def valid_tld?(host)
        return true unless options[:tld]
        tld = host[/\.(.*?)$/, 1].to_s.downcase

        self.class.tlds.include?(tld)
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
