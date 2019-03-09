# frozen_string_literal: true

require "test_helper"

class Ipv6Test < Minitest::Test
  let(:user) { User.new }

  test "is valid" do
    User.validates_ip_address :url, only: :v6
    user.url = "FE80:0000:0000:0000:0202:B3FF:FE1E:8329"

    assert user.valid?
  end

  test "is invalid" do
    User.validates_ip_address :url, only: :v6
    user.url = "192.168.1.2"

    refute user.valid?
    assert_includes user.errors[:url], "is not a valid IPv6 address"
  end
end
