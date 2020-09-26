# frozen_string_literal: true

module Validators
  class DisposableEmails
    def self.all
      @all ||=
        begin
          require "email_data"
          EmailData.disposable_emails
        rescue LoadError
          raise "email_data is not part of the bundle. Add it to Gemfile."
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
