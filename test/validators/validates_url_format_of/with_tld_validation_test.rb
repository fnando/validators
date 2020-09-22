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

  test "rejects invalid TLD (alternative syntax)" do
    user_model = Class.new do
      include ActiveModel::Validations
      attr_accessor :site_url

      def self.name
        "User"
      end

      validates :site_url, url: {tld: true}
    end

    user = user_model.new
    user.site_url = "https://example.xy"

    refute user.valid?
  end
end
