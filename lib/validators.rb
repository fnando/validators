require "active_record"
require "validators/validates_email_format_of"
require "validators/validates_ownership_of"

module Validators
  EMAIL_FORMAT = /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
end
