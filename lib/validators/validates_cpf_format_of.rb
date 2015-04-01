module ActiveModel
  module Validations
    class CpfValidator < EachValidator
      def validate_each(record, attribute, value)
        return if value.blank? && options[:allow_blank]
        return if value.nil? && options[:allow_nil]

        record.errors.add(attribute, :invalid_cpf,
          message: options[:message],
          value: value
        ) unless CPF.valid?(value)
      end
    end

    module ClassMethods
      # Validates whether or not the specified CPF is valid.
      #
      #   class User < ActiveRecord::Base
      #     validates_cpf_format_of :document
      #   end
      #
      def validates_cpf_format_of(*attr_names)
        require "cpf"
        validates_with CpfValidator, _merge_attributes(attr_names)
      rescue LoadError
        fail "cpf_cnpj is not part of the bundle. Add it to Gemfile."
      end

      alias_method :validates_cpf, :validates_cpf_format_of
    end
  end
end
