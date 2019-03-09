# frozen_string_literal: true

require "test_helper"

class ValidatesurlFormatUrlWithTldValidationTest < Minitest::Test
  test "rejects invalid TLD" do
    user = UserWithTLD.new("http://example.xy")
    refute user.valid?
  end

  TLDs.each do |tld|
    test "accepts #{tld} as TLD" do
      user = UserWithTLD.new("http://example.#{tld}")
      assert user.valid?
    end
  end
end
