# frozen_string_literal: true

module Validators
  class DisposableEmails
    def self.all
      @all ||=
        begin
          Validators.require_dependency! "root_domain"
          Validators.require_dependency! "email_data"
          EmailData.disposable_emails
        end
    end

    def self.include?(email)
      mailbox, domain = email.to_s.split("@")
      mailbox = mailbox.to_s.gsub(".", "")
      mailbox = mailbox.gsub(/\+(.+)?\Z/, "")

      all.include?("#{mailbox}@#{domain}")
    end
  end
end
