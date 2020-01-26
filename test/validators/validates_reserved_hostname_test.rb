# frozen_string_literal: true

require "test_helper"

class ValidatesReservedHostnameTest < Minitest::Test
  test "rejects reserved hostname" do
    model = build_model do
      attr_accessor :hostname
      validates_reserved_hostname :hostname
    end

    instance = model.new(hostname: "www")

    refute instance.valid?
    assert_includes instance.errors[:hostname],
                    "www is a reserved hostname"
  end

  test "rejects reserved hostname with pattern" do
    model = build_model do
      attr_accessor :hostname
      validates_reserved_hostname :hostname
    end

    instance = model.new(hostname: "www1234")

    refute instance.valid?
  end

  test "uses custom list" do
    model = build_model do
      attr_accessor :hostname
      validates_reserved_hostname :hostname, in: %w[nope]
    end

    instance = model.new(hostname: "nope")

    refute instance.valid?
  end
end
