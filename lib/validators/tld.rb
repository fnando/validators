module Validators
  class TLD
    TLD_FILE_PATH = File.expand_path('../../../data/tld.txt', __FILE__)

    def self.all
      @tld ||= File.read(TLD_FILE_PATH).lines.map(&:chomp)
    end

    def self.host_with_valid_tld?(host)
      return false if host.split('.').size == 1
      valid? host[/\.([^.]+)$/, 1].to_s.downcase
    end

    def self.valid?(tld)
      all.include?(tld)
    end
  end
end
