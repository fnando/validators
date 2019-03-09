# frozen_string_literal: true

module Validators
  class Hostname
    def self.valid?(host)
      host = host.to_s
      uri = URI(host)

      host.present? &&
        uri.host.nil? &&
        uri.scheme.nil? &&
        uri.fragment.nil? &&
        uri.query.nil? &&
        uri.path == host &&
        host.split(".").all? {|label| valid_label?(label) } &&
        host.size <= 255 &&
        Validators::TLD.host_with_valid_tld?(host)
    rescue URI::InvalidURIError
      false
    end

    def self.valid_label?(label)
      !label.start_with?("-") &&
        !label.match(/\A\d+\z/) &&
        label.match(/\A[a-z0-9-]{1,63}\z/i)
    end
  end
end
