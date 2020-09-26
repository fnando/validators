# frozen_string_literal: true

module Validators
  class TLD
    def self.all
      @all ||=
        begin
          require "email_data"
          EmailData.tlds
        rescue LoadError
          raise "email_data is not part of the bundle. Add it to Gemfile."
        end
    end

    def self.host_with_valid_tld?(host)
      host = host.to_s

      return false if host.split(".").size == 1

      include?(host[/\.([^.]+)$/, 1].to_s.downcase)
    end

    def self.include?(tld)
      all.include?(tld)
    end
  end
end
