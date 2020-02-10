# frozen_string_literal: true

module ActiveModel
  module Validations
    class UsernameValidator < SubdomainValidator
    end

    module ClassMethods
      def validates_username(*attr_names)
        options = _merge_attributes(attr_names).merge(error_name: :username)
        validates_with UsernameValidator, options
      end
    end
  end
end
