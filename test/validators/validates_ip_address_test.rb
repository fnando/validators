# frozen_string_literal: true

require "test_helper"

class ValidatesIpAddressTest < Minitest::Test
  let(:user) { User.new }

  test "is valid with IPv4" do
    User.validates_ip_address :url
    user.url = "192.168.1.2"

    assert user.valid?
  end

  test "is valid with IPv6" do
    User.validates_ip_address :url
    user.url = "FE80:0000:0000:0000:0202:B3FF:FE1E:8329"

    assert user.valid?
  end

  test "allows blank values" do
    User.validates_ip_address :url, allow_blank: true
    user.url = ""

    assert user.valid?
  end

  test "allows nil values" do
    User.validates_ip_address :url, allow_nil: true
    user.url = nil

    assert user.valid?
  end
end
