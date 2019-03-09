# frozen_string_literal: true

module ActiveModel
  module Validations
    class DatetimeValidator < EachValidator
      def date?(value)
        value.is_a?(Date) || value.is_a?(Time)
      end

      def validate_each(record, attribute, value)
        return if value.blank? && options[:allow_blank]
        return if value.nil? && options[:allow_nil]

        unless date?(value)
          record.errors.add(
            attribute,
            :invalid_date,
            message: options[:message],
            value: value
          )
        end

        return unless date?(value)

        validate_after_option(record, attribute, value)
        validate_before_option(record, attribute, value)
      end

      private def date_for(record, value, option)
        date = case option
               when :today
                 Date.today
               when :now
                 Time.now
               when Time, Date, DateTime, ActiveSupport::TimeWithZone
                 option
               when Proc
                 option.call(record)
               else
                 record.__send__(option) if record.respond_to?(option)
               end

        if date.is_a?(Time)
          value = value.to_time
        elsif date.is_a?(Date)
          value = value.to_date
        end

        [date, value]
      end

      private def validate_after_option(record, attribute, value)
        return unless options[:after]

        date, value = date_for(record, value, options[:after])

        return if value.present? && date.present? && (value && date && value > date)

        record.errors.add(
          attribute,
          :invalid_date_after,
          message: options[:after_message],
          value: value,
          date: (date?(date) ? I18n.l(date) : date.inspect)
        )
      end

      private def validate_before_option(record, attribute, value)
        return unless options[:before]

        date, value = date_for(record, value, options[:before])

        return if value.present? && date.present? && (value && date && value < date)

        record.errors.add(
          attribute,
          :invalid_date_before,
          message: options[:before_message],
          value: value,
          date: I18n.l(date)
        )
      end
    end

    module ClassMethods
      # Validates whether or not the specified e-mail address is valid.
      #
      #   class User < ActiveRecord::Base
      #     validates_datetime :birth
      #   end
      #
      # Other usages:
      #
      #   validates_datetime :starts_at, after: 2.years.ago
      #   validates_datetime :starts_at, before: 2.years.ago
      #   validates_datetime :starts_at, before: :today
      #   validates_datetime :starts_at, before: :now
      #   validates_datetime :starts_at, before: :ends_at
      #   validates_datetime :ends_at, after: :starts_at
      #
      def validates_datetime(*attr_names)
        validates_with DatetimeValidator, _merge_attributes(attr_names)
      end
    end
  end
end
