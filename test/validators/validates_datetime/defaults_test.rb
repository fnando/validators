# frozen_string_literal: true

require "test_helper"

class ValidatesDatetimeDefaultsTest < Minitest::Test
  let(:user) { User.new }

  setup do
    User.validates_datetime :registered_at
    User.validates :birthday, datetime: true
  end

  VALID_DATES.each do |date|
    test "accepts #{date.inspect} as valid date" do
      user.registered_at = date
      user.birthday = date

      assert user.valid?
    end
  end

  INVALID_DATES.each do |date|
    test "rejects #{date.inspect} as valid date" do
      user.registered_at = date
      user.birthday = date

      refute user.valid?
      refute user.errors[:registered_at].empty?
      refute user.errors[:birthday].empty?
    end
  end

  test "includes default error message" do
    user.registered_at = nil

    refute user.valid?
    assert_includes user.errors[:registered_at], "is not a valid date"
  end
end
