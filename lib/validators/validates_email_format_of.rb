# frozen_string_literal: true

module ActiveModel
  module Validations
    class EmailValidator < EachValidator
      AT_SIGN = "@"

      def validate_each(record, attribute, value)
        allow_disposable = options.fetch(:disposable, false)
        check_tld = options.fetch(:tld, false)

        return if value.blank? && options[:allow_blank]
        return if value.nil? && options[:allow_nil]

        validate_tld(record, attribute, value, options) if check_tld
        validate_email_format(record, attribute, value, options)
        validate_disposable_domain(record, attribute, value, options) unless allow_disposable
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

      def validate_disposable_domain(record, attribute, value, _options)
        return unless value

        hostname = value.to_s.split(AT_SIGN).last.to_s.downcase
        root_domain = RootDomain.call(hostname)

        return unless Validators::DisposableDomains.include?(root_domain)

        record.errors.add(
          attribute,
          :disposable_domain,
          value: value
        )
      end

      def validate_disposable_email(record, attribute, value, _options)
        return unless value
        return unless Validators::DisposableEmails.include?(value)

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
        Validators.require_dependency! "root_domain"
        Validators.require_dependency! "email_data"
        validates_with EmailValidator, _merge_attributes(attr_names)
      end

      alias_method :validates_email, :validates_email_format_of
    end
  end
end
