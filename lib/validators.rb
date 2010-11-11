require "active_record"
require "validators/constants"
require "validators/validates_ip_address"
require "validators/validates_email_format_of"
require "validators/validates_url_format_of"
require "validators/validates_ownership_of"

module Validators
  autoload :Ip, "validators/ip"
end
