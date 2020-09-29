# frozen_string_literal: true

module ActiveModel
  module Validations
    class SshPublicKeyValidator < EachValidator
      def validate_each(record, attribute, value)
        return if value.blank? && options[:allow_blank]
        return if value.nil? && options[:allow_nil]
        return if SSHKey.valid_ssh_public_key?(value)

        record.errors.add(
          attribute,
          :invalid_ssh_public_key,
          message: options[:message],
          value: value
        )
      end
    end

    module ClassMethods
      # Validates whether or not the specified CNPJ is valid.
      #
      #   class User < ActiveRecord::Base
      #     validates_ssh_public_key :key
      #   end
      #
      def validates_ssh_public_key(*attr_names)
        Validators.require_dependency! "sshkey"
        validates_with SshPublicKeyValidator, _merge_attributes(attr_names)
      end
    end
  end
end
