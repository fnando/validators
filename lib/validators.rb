require "active_record"
require "validators/constants"
require "validators/validates_cep_format_of"
require "validators/validates_cnpj_format_of"
require "validators/validates_cpf_format_of"
require "validators/validates_datetime"
require "validators/validates_email_format_of"
require "validators/validates_ip_address"
require "validators/validates_ownership_of"
require "validators/validates_url_format_of"

module Validators
  autoload :Cep, "validators/cep"
  autoload :Cnpj, "validators/cnpj"
  autoload :Cpf, "validators/cpf"
  autoload :Ip, "validators/ip"
end
