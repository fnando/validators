# frozen_string_literal: true

require "test_helper"

class IpTest < Minitest::Test
  VALID_IPV4.each do |ip|
    test "accepts #{ip.inspect} as ip address (v4)" do
      assert Validators::Ip.v4?(ip)
    end
  end

  VALID_IPV6.each do |ip|
    test "accepts #{ip.inspect} as ip address (v6)" do
      assert Validators::Ip.v6?(ip)
    end
  end

  (VALID_IPV4 + VALID_IPV6).each do |ip|
    test "accepts #{ip.inspect} as ip address" do
      assert Validators::Ip.valid?(ip)
    end
  end
end
