# frozen_string_literal: true

require "test_helper"

class ValidatesReservedUsernameTest < Minitest::Test
  test "rejects reserved username" do
    model = build_model do
      attr_accessor :username
      validates_reserved_username :username
    end

    instance = model.new(username: "www")

    refute instance.valid?
    assert_includes instance.errors[:username],
                    "www is a reserved username"
  end

  test "rejects reserved username with pattern" do
    model = build_model do
      attr_accessor :username
      validates_reserved_username :username
    end

    instance = model.new(username: "www1234")

    refute instance.valid?
  end

  test "uses custom list" do
    model = build_model do
      attr_accessor :username
      validates_reserved_username :username, in: %w[nope]
    end

    instance = model.new(username: "nope")

    refute instance.valid?
  end
end
