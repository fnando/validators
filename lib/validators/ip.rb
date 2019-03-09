# frozen_string_literal: true

module Validators
  module Ip
    # Extracted from Ruby 1.8.7
    def v4?(addr)
      matches = addr.match(/\A(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})\Z/)
      matches&.captures&.all? {|i| i.to_i < 256 }
    end

    # Extracted from Ruby 1.8.7
    def v6?(addr)
      # IPv6 (normal)
      return true if /\A[\da-f]{1,4}(:[\da-f]{1,4})*\Z/i =~ addr
      return true if /\A[\da-f]{1,4}(:[\da-f]{1,4})*::([\da-f]{1,4}(:[\da-f]{1,4})*)?\Z/i =~ addr
      return true if /\A::([\da-f]{1,4}(:[\da-f]{1,4})*)?\Z/i =~ addr
      # IPv6 (IPv4 compat)
      return true if /\A[\da-f]{1,4}(:[\da-f]{1,4})*:/i =~ addr && v4?($')
      return true if /\A[\da-f]{1,4}(:[\da-f]{1,4})*::([\da-f]{1,4}(:[\da-f]{1,4})*:)?/i =~ addr && v4?($')
      return true if /\A::([\da-f]{1,4}(:[\da-f]{1,4})*:)?/i =~ addr && v4?($')

      false
    end

    def valid?(addr)
      v4?(addr) || v6?(addr)
    end

    module_function :v4?
    module_function :v6?
    module_function :valid?
  end
end
