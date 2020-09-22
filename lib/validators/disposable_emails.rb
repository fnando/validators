# frozen_string_literal: true

module Validators
  class DisposableEmails
    FILE_PATH = File.expand_path("../../data/disposable_emails.txt", __dir__)

    def self.all
      @all ||= File.read(FILE_PATH).lines.map(&:chomp)
    end

    def self.include?(email)
      mailbox, domain = email.to_s.split("@")
      mailbox = mailbox.to_s.gsub(".", "")
      mailbox = mailbox.gsub(/\+(.+)?\Z/, "")

      all.include?("#{mailbox}@#{domain}")
    end
  end
end
