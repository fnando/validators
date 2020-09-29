# frozen_string_literal: true

module ActiveModel
  module Validations
    class CnpjValidator < EachValidator
      def validate_each(record, attribute, value)
        return if value.blank? && options[:allow_blank]
        return if value.nil? && options[:allow_nil]
        return if CNPJ.valid?(value)

        record.errors.add(
          attribute,
          :invalid_cnpj,
          message: options[:message],
          value: value
        )
      end
    end

    module ClassMethods
      # Validates whether or not the specified CNPJ is valid.
      #
      #   class User < ActiveRecord::Base
      #     validates_cnpj_format_of :document
      #   end
      #
      def validates_cnpj_format_of(*attr_names)
        Validators.require_dependency! "cpf_cnpj"
        require "cnpj"
        validates_with CnpjValidator, _merge_attributes(attr_names)
      end

      alias_method :validates_cnpj, :validates_cnpj_format_of
    end
  end
end
