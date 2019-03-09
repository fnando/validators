# frozen_string_literal: true

module ActiveModel
  module Validations
    class OwnershipValidator < EachValidator
      WITH_OPTIONS = %w[String Symbol].freeze

      def validate_each(record, attribute, value)
        owner = record.send(options[:with])
        actual_owner = value ? value.send(options[:with]) : nil

        return unless value
        return if owner == actual_owner

        record.errors.add(
          attribute,
          :invalid_owner,
          message: options[:message]
        )
      end

      def check_validity!
        raise ArgumentError, ":with is required" unless options.key?(:with)
        raise ArgumentError, ":with option must be a string or a symbol" unless WITH_OPTIONS.include?(options[:with].class.name)
      end
    end

    module ClassMethods
      # Validates whether the owner of the specified attribute is the same from the current object.
      #
      #   class Task < ActiveRecord::Base
      #     belongs_to :user
      #     belongs_to :category
      #
      #     validates_ownership_of :category, with: :user
      #   end
      #
      #   user = User.find(1)
      #   another_user = User.find(2)
      #
      #   user_category = user.categories.first
      #   another_user_category = another_user.categories.first
      #
      #   task = user.tasks.create(category: user_category)
      #   task.valid?
      #   #=> true
      #
      #   task = user.tasks.create(category: another_user_category)
      #   task.valid?
      #   #=> false
      #
      def validates_ownership_of(*attr_names)
        validates_with OwnershipValidator, _merge_attributes(attr_names)
      end
    end
  end
end
