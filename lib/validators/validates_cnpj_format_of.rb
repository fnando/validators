module ActiveModel
  module Validations
    class CnpjValidator < EachValidator
      def validate_each(record, attribute, value)
        unless Validators::Cnpj.valid?(value.to_s)
          record.errors.add(
            attribute, :invalid_cnpj,
            :message => options[:message], :value => value
          )
        end
      end
    end

    module ClassMethods
      # Validates whether or not the specified CNPJ is valid.
      #
      #   class Company < ActiveRecord::Base
      #     validates_cnpj_format_of :cnpj
      #   end
      #
      def validates_cnpj_format_of(*attr_names)
        validates_with CnpjValidator, _merge_attributes(attr_names)
      end

      alias_method :validates_cnpj, :validates_cnpj_format_of
    end
  end
end
