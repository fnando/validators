# frozen_string_literal: true

module Validators
  class TLD
    def self.all
      @all ||=
        begin
          Validators.require_dependency! "email_data"
          EmailData.tlds
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
