# frozen_string_literal: true

require "test_helper"

class WithTldValidationTest < Minitest::Test
  test "rejects invalid TLD" do
    server = ServerWithTLD.new("example.xy")
    refute server.valid?
  end

  test "rejects only host label" do
    server = ServerWithTLD.new("com")
    refute server.valid?
  end

  TLDs.each do |tld|
    test "accepts #{tld} as TLD" do
      server = ServerWithTLD.new("example.#{tld}")
      assert server.valid?
    end
  end

  test "accepts example.com.br" do
    server = ServerWithTLD.new("example.com.br")
    assert server.valid?
  end
end
