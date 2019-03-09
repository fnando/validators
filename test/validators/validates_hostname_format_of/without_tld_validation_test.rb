# frozen_string_literal: true

require "test_helper"

class WithoutTldValidationTest < Minitest::Test
  VALID_HOSTNAMES.each do |host|
    test "accepts #{host}" do
      server = ServerWithoutTLD.new(host)
      assert server.valid?
    end
  end

  INVALID_HOSTNAMES.each do |host|
    test "rejects #{host}" do
      server = ServerWithoutTLD.new(host)
      refute server.valid?
    end
  end

  test "rejects nil hostname" do
    server = ServerWithoutTLD.new(nil)
    refute server.valid?
  end

  test "rejects blank hostname" do
    server = ServerWithoutTLD.new("")
    refute server.valid?
  end

  test "rejects invalid uris" do
    server = ServerWithoutTLD.new("\\DERP!")
    refute server.valid?
  end
end
