module ActiveModel
  module Validations
    class EmailValidator < EachValidator
      AT_SIGN = "@".freeze

      def validate_each(record, attribute, value)
        allow_disposable = options.fetch(:disposable, false)
        check_tld = options.fetch(:tld, false)

        return if value.blank? && options[:allow_blank]
        return if value.nil? && options[:allow_nil]

        validate_tld(record, attribute, value, options) if check_tld
        validate_email_format(record, attribute, value, options)
        validate_disposable_email(record, attribute, value, options) unless allow_disposable
      end

      def validate_email_format(record, attribute, value, options)
        return if value.to_s =~ Validators::EMAIL_FORMAT
        return if value.to_s =~ Validators::MICROSOFT_EMAIL_FORMAT

        record.errors.add(
          attribute,
          :invalid_email,
          message: options[:message],
          value: value
        )
      end

      def validate_tld(record, attribute, value, options)
        host = value.to_s.split(AT_SIGN).last
        return if Validators::TLD.host_with_valid_tld?(host)

        record.errors.add(
          attribute,
          :invalid_hostname,
          message: options[:message],
          value: value
        )
      end

      def validate_disposable_email(record, attribute, value, options)
        hostname = value.to_s.split(AT_SIGN).last.to_s.downcase

        return unless Validators::DisposableHostnames.all.include?(hostname)

        record.errors.add(
          attribute,
          :disposable_email,
          value: value
        )
      end
    end

    module ClassMethods
      # Validates whether or not the specified e-mail address is valid.
      #
      #   class User < ActiveRecord::Base
      #     validates_email_format_of :email
      #   end
      #
      def validates_email_format_of(*attr_names)
        validates_with EmailValidator, _merge_attributes(attr_names)
      end

      alias_method :validates_email, :validates_email_format_of
    end
  end
end
