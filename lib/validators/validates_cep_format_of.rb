module ActiveModel
  module Validations
    class CepValidator < EachValidator
      def validate_each(record, attribute, value)
        unless Validators::Cep.valid?(value.to_s)
          record.errors.add(
            attribute, :invalid_cep,
            :message => options[:message], :value => value
          )
        end
      end
    end

    module ClassMethods
      # Validates whether or not the specified CEP is valid.
      #
      #   class Company < ActiveRecord::Base
      #     validates_cep_format_of :cep
      #   end
      #
      def validates_cep_format_of(*attr_names)
        validates_with CepValidator, _merge_attributes(attr_names)
      end

      alias_method :validates_cep, :validates_cep_format_of
    end
  end
end
