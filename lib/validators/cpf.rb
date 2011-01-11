module Validators
  module Cpf
    extend self

    def valid?(cpf_number)
      cpf_number.gsub!(/\D+/i, "")

      return false if cpf_number.nil?
      return false if cpf_number.strip == ""
      return false if cpf_number.size != 11
      return false if %W[00000000000 11111111111 22222222222 33333333333 44444444444 55555555555 66666666666 77777777777 88888888888 99999999999].include? cpf_number

      cpf = cpf_number.slice(0, 9)

      first_digit = calculate_digit(cpf, 10)
      second_digit = calculate_digit("#{cpf}#{first_digit}", 11)
      cpf = "#{cpf}#{first_digit}#{second_digit}"

      cpf == cpf_number
    end

    private
    def calculate_digit(numbers, first_number)
      digit = 0
      (0...first_number-1).each { |i| digit = digit + numbers[i].to_i * (first_number-i) }
      digit = (digit % 11) < 2 ? 0 : 11 - (digit % 11)

      digit
    end
  end
end
