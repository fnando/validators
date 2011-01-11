module Validators
  module Cep
    extend self

    def valid?(cep_number)
      cep_number.gsub!(/\D+/i, "")

      return false if cep_number.nil?
      return false if cep_number.strip == ""
      return false if cep_number.size != 8

      true
    end
  end
end
