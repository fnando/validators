# frozen_string_literal: true

$VERBOSE = nil

require "simplecov"

SimpleCov.start do
  add_filter "test/support"
end

require "bundler/setup"
require "active_record"
require "validators"
require "active_support/all"

require "minitest/utils"
require "minitest/autorun"

def build_email_with_filter(email)
  mailbox, domain = email.split("@")
  "#{mailbox}+#{SecureRandom.hex(3)}@#{domain}"
end

def build_email_with_dots(email)
  mailbox, domain = email.split("@")
  new_mailbox = mailbox.chars.map {|char| [char, "."] }.flatten[0..-2].join

  "#{new_mailbox}@#{domain}"
end

Time.zone = "America/Sao_Paulo"
TLDs = Validators::TLD.all.sample(10)
DISPOSABLE_DOMAINS = Validators::DisposableDomains.all.sample(10)
DISPOSABLE_EMAILS = Validators::DisposableEmails.all +
                    Validators::DisposableEmails.all.sample(10).map {|email| build_email_with_filter(email) } +
                    Validators::DisposableEmails.all.sample(10).map {|email| build_email_with_dots(email) } +
                    Validators::DisposableEmails.all.sample(10).map {|email| build_email_with_filter(build_email_with_dots(email)) }

Dir[File.join(__dir__, "support/**/*.rb")].sort.each {|f| require f }

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"
load "schema.rb"

module Minitest
  class Test
    setup do
      I18n.locale = :en
      Time.zone = "America/Sao_Paulo"

      ActiveRecord::Base.descendants.each do |model|
        next if %w[ActiveRecord::InternalMetadata ActiveRecord::SchemaMigration primary::SchemaMigration].include?(model.name)

        model.delete_all

        Object.class_eval do
          remove_const model.name if const_defined?(model.name)
        end
      end

      load File.join(__dir__, "support/models.rb")
    end
  end
end
