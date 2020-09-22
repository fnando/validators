# frozen_string_literal: true

module Validators
  class ReservedSubdomains
    FILE_PATH = File.expand_path("../../data/reserved_subdomains.txt", __dir__)

    def self.reserved?(hostname, matchers = nil)
      matchers = parse_list(matchers) if matchers
      matchers ||= all
      match_any?(matchers, hostname)
    end

    def self.all
      @all ||= File.read(FILE_PATH).lines.map {|matcher| parse(matcher.chomp) }
    end

    def self.parse(matcher)
      return matcher unless matcher.start_with?("/")

      Regexp.compile(matcher[%r{/(.*?)/}, 1])
    end

    def self.parse_list(matchers)
      matchers.map {|matcher| parse(matcher) }
    end

    def self.match_any?(matchers, hostname)
      hostname = normalize(hostname)
      matchers.any? {|matcher| match?(matcher, hostname) }
    end

    def self.normalize(hostname)
      hostname.downcase.gsub(/[_-]/, "")
    end

    def self.match?(matcher, hostname)
      case matcher
      when String
        matcher == hostname
      when Regexp
        hostname =~ matcher
      else
        raise "Unknown matcher type: #{matcher.class}"
      end
    end
  end
end
