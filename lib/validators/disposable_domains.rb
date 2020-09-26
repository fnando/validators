# frozen_string_literal: true

module Validators
  class DisposableDomains
    def self.all
      @all ||=
        begin
          require "email_data"
          EmailData.disposable_domains
        rescue LoadError
          raise "email_data is not part of the bundle. Add it to Gemfile."
        end
    end

    def self.include?(domain)
      all.include?(domain)
    end
  end
end
