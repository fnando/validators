module Validators
  module Cnpj
    extend self

    def valid?(cnpj_number)
      cnpj_number.gsub!(/\D+/i, "")

      return false if cnpj_number.nil?
      return false if cnpj_number.strip == ""
      return false if cnpj_number.size != 14
      return false if %W[00000000000000 11111111111111 22222222222222 33333333333333 44444444444444 55555555555555 66666666666666 77777777777777 88888888888888 99999999999999].include? cnpj_number

      cnpj = cnpj_number.slice(0, 12)

      first_digit = calculate_digit(cnpj, :first)
      second_digit = calculate_digit("#{cnpj}#{first_digit}", :second)
      cnpj = "#{cnpj}#{first_digit}#{second_digit}"

      cnpj == cnpj_number
    end

    private
    def calculate_digit(numbers, type)
      digits = { :first => [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2],
                 :second => [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2] }

      digit = 0
      (0...numbers.size).each { |i| digit = digit + numbers[i].to_i * digits[type.to_sym][i] }
      digit = (digit % 11) < 2 ? 0 : 11 - (digit % 11)

      digit
    end
  end
end
