require "active_record"
require File.dirname(__FILE__) + "/validators/constants"
require File.dirname(__FILE__) + "/validators/validates_cep_format_of"
require File.dirname(__FILE__) + "/validators/validates_cnpj_format_of"
require File.dirname(__FILE__) + "/validators/validates_cpf_format_of"
require File.dirname(__FILE__) + "/validators/validates_email_format_of"
require File.dirname(__FILE__) + "/validators/validates_ip_address"
require File.dirname(__FILE__) + "/validators/validates_ownership_of"
require File.dirname(__FILE__) + "/validators/validates_url_format_of"

module Validators
  autoload :Cep, "validators/cep"
  autoload :Cnpj, "validators/cnpj"
  autoload :Cpf, "validators/cpf"
  autoload :Ip, "validators/ip"
end
