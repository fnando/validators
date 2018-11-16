module ActiveModel
  module Validations
    class CpfCnpjValidator < EachValidator
      def validate_each(record, attribute, value)
        return if value.blank? && options[:allow_blank]
        return if value.nil? && options[:allow_nil]
        return if CPF.valid?(value) || CNPJ.valid?(value)

        record.errors.add(attribute, :invalid_cpf_or_cnpj,
          message: options[:message],
          value: value
        )
      end
    end

    module ClassMethods
      # Validates whether or not the specified CPF or CNPJ is valid.
      #
      #   class User < ActiveRecord::Base
      #     validates_cpf_or_cnpj_format_of :document
      #   end
      #
      def validates_cpf_or_cnpj_format_of(*attr_names)
        require "cpf"
        require "cnpj"
        validates_with CpfCnpjValidator, _merge_attributes(attr_names)
      rescue LoadError
        fail "cpf_cnpj is not part of the bundle. Add it to Gemfile."
      end

      alias_method :validates_cpf_or_cnpj, :validates_cpf_or_cnpj_format_of
    end
  end
end
