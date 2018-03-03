module Validators
  class TLD
    FILE_PATH = File.expand_path("../../../data/tld.json", __FILE__)

    def self.all
      @tld ||= JSON.load(File.read(FILE_PATH))
    end

    def self.host_with_valid_tld?(host)
      return false if host.split(".").size == 1
      valid? host[/\.([^.]+)$/, 1].to_s.downcase
    end

    def self.valid?(tld)
      all.include?(tld)
    end
  end
end
