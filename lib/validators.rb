# frozen_string_literal: true

require "json"

module Validators
  require "validators/constants"
  require "validators/ip"
  require "validators/tld"
  require "validators/hostname"
  require "validators/disposable_hostnames"
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
end
