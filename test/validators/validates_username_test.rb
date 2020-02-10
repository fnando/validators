# frozen_string_literal: true

require "test_helper"

class ValidatesUsernameTest < Minitest::Test
  test "rejects invalid username" do
    model = build_model do
      attr_accessor :username
      validates_username :username
    end

    instance = model.new(username: "1234")

    refute instance.valid?
    assert_includes instance.errors[:username], "is invalid"
  end

  test "rejects reserved username" do
    model = build_model do
      attr_accessor :username
      validates_username :username
    end

    instance = model.new(username: "www")

    refute instance.valid?
    assert_includes instance.errors[:username],
                    "www is a reserved username"
  end

  test "rejects reserved username with pattern" do
    model = build_model do
      attr_accessor :username
      validates_username :username
    end

    instance = model.new(username: "www1234")

    refute instance.valid?
  end

  test "uses custom list" do
    model = build_model do
      attr_accessor :username
      validates_username :username, in: %w[nope]
    end

    instance = model.new(username: "nope")

    refute instance.valid?
  end

  test "ignores reserved username validation" do
    model = build_model do
      attr_accessor :username
      validates_username :username, reserved: false
    end

    instance = model.new(username: "www")

    assert instance.valid?
  end
end
