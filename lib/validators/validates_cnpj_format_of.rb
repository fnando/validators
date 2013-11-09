module ActiveModel
  module Validations
    class CnpjValidator < EachValidator
      def validate_each(record, attribute, value)
        record.errors.add(attribute, :invalid_cnpj,
          message: options[:message],
          value: value
        ) unless CNPJ.valid?(value)
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
        require "cnpj"
        validates_with CnpjValidator, _merge_attributes(attr_names)
      rescue LoadError
        fail "cpf_cnpj is not part of the bundle. Add it to Gemfile."
      end

      alias_method :validates_cnpj, :validates_cnpj_format_of
    end
  end
end
