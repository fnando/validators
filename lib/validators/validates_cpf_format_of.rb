module ActiveModel
  module Validations
    class CpfValidator < EachValidator
      def validate_each(record, attribute, value)
        unless Validators::Cpf.valid?(value.to_s)
          record.errors.add(
            attribute, :invalid_cpf,
            :message => options[:message], :value => value
          )
        end
      end
    end

    module ClassMethods
      # Validates whether or not the specified CPF is valid.
      #
      #   class User < ActiveRecord::Base
      #     validates_cpf_format_of :cpf
      #   end
      #
      def validates_cpf_format_of(*attr_names)
        validates_with CpfValidator, _merge_attributes(attr_names)
      end

      alias_method :validates_cpf, :validates_cpf_format_of
    end
  end
end
