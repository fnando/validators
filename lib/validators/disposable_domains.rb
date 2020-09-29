# frozen_string_literal: true

module Validators
  class DisposableDomains
    def self.all
      @all ||=
        begin
          Validators.require_dependency! "root_domain"
          Validators.require_dependency! "email_data"
          EmailData.disposable_domains
        end
    end

    def self.include?(domain)
      all.include?(domain)
    end
  end
end
