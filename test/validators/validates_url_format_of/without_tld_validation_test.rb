# frozen_string_literal: true

require "test_helper"

class ValidatesurlFormatUrlWithoutTldValidationTest < Minitest::Test
  setup do
    User.validates_url_format_of :url, allow_blank: false
  end

  VALID_URLS.each do |url|
    test "accepts #{url.inspect} as a valid url" do
      user = User.new(url: url)
      assert user.valid?
    end
  end

  INVALID_URLS.each do |url|
    test "rejects #{url.inspect} as a valid url" do
      user = User.new(url: url)
      refute user.valid?
    end
  end

  test "defines alias method" do
    assert User.respond_to?(:validates_url)
  end

  test "uses default error message" do
    user = User.new(url: "invalid")
    refute user.valid?
    assert_includes user.errors[:url], "is not a valid address"
  end

  test "uses I18n string as error message [pt-BR]" do
    I18n.locale = :"pt-BR"
    user = User.new(url: "invalid")
    refute user.valid?
    assert_includes user.errors[:url], "não parece ser uma URL válida"
  end

  test "rejects nil urls" do
    user = User.new(url: nil)
    refute user.valid?
  end

  test "rejects blank urls" do
    user = User.new(url: "")
    refute user.valid?
  end

  test "accepts invalid TLD (alternative syntax)" do
    user_model = Class.new do
      include ActiveModel::Validations
      attr_accessor :site_url

      def self.name
        "User"
      end

      validates :site_url, url: {tld: false}
    end

    user = user_model.new
    user.site_url = "https://example.xy"

    assert user.valid?
  end
end
