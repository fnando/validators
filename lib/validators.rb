# frozen_string_literal: true

require "json"

module Validators
  require "validators/constants"
  require "validators/ip"
  require "validators/tld"
  require "validators/hostname"
  require "validators/disposable_domains"
  require "validators/disposable_emails"
  require "validators/reserved_subdomains"

  require "validators/validates_datetime"
  require "validators/validates_ip_address"
  require "validators/validates_email_format_of"
  require "validators/validates_url_format_of"
  require "validators/validates_ownership_of"
  require "validators/validates_cpf_format_of"
  require "validators/validates_cnpj_format_of"
  require "validators/validates_ssh_private_key"
  require "validators/validates_ssh_public_key"
  require "validators/validates_hostname_format_of"
  require "validators/validates_subdomain"
  require "validators/validates_username"

  I18n.load_path += Dir[File.join(__dir__, "validators/locale/*.yml")]

  def self.require_dependency!(dep)
    require dep
  rescue LoadError
    raise "#{dep} is not part of the bundle. " \
          "Add it to your project's Gemfile."
  end
end
