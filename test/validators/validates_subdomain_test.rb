# frozen_string_literal: true

require "test_helper"

class ValidatesSubdomainTest < Minitest::Test
  test "don't explode with nil values" do
    model = build_model do
      attr_accessor :subdomain
      validates_subdomain :subdomain
    end

    instance = model.new(subdomain: nil)

    refute instance.valid?
    assert_includes instance.errors[:subdomain], "is invalid"
  end

  test "rejects invalid subdomain" do
    model = build_model do
      attr_accessor :subdomain
      validates_subdomain :subdomain
    end

    instance = model.new(subdomain: "1234")

    refute instance.valid?
    assert_includes instance.errors[:subdomain], "is invalid"
  end

  test "rejects reserved subdomain" do
    model = build_model do
      attr_accessor :subdomain
      validates_subdomain :subdomain
    end

    instance = model.new(subdomain: "www")

    refute instance.valid?
    assert_includes instance.errors[:subdomain],
                    "www is a reserved subdomain"
  end

  test "rejects reserved subdomain with pattern" do
    model = build_model do
      attr_accessor :subdomain
      validates_subdomain :subdomain
    end

    instance = model.new(subdomain: "www1234")

    refute instance.valid?
  end

  test "uses custom list" do
    model = build_model do
      attr_accessor :subdomain
      validates_subdomain :subdomain, in: %w[nope]
    end

    instance = model.new(subdomain: "nope")

    refute instance.valid?
  end

  test "ignores reserved subdomain validation" do
    model = build_model do
      attr_accessor :subdomain
      validates_subdomain :subdomain, reserved: false
    end

    instance = model.new(subdomain: "www")

    assert instance.valid?
  end
end
