# frozen_string_literal: true

module Validators
  class TLD
    FILE_PATH = File.expand_path("../../data/tld.json", __dir__)

    def self.all
      @all ||= JSON.parse(File.read(FILE_PATH))
    end

    def self.host_with_valid_tld?(host)
      return false if host.to_s.split(".").size == 1

      valid?(host[/\.([^.]+)$/, 1].to_s.downcase)
    end

    def self.valid?(tld)
      all.include?(tld)
    end
  end
end
