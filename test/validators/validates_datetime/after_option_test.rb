# frozen_string_literal: true

require "test_helper"

class ValidatesDatetimeAfterOptionTest < Minitest::Test
  let(:user) { User.new }

  test "rejects when date is set to before :after option" do
    future_date = 1.week.from_now
    User.validates_datetime :registered_at, after: future_date
    user.registered_at = Time.now

    refute user.valid?
    assert_includes user.errors[:registered_at], "needs to be after #{I18n.l(future_date)}"
  end

  test "accepts when date is set accordingly to the :after option" do
    User.validates_datetime :registered_at, after: 1.week.from_now
    user.registered_at = 2.weeks.from_now

    assert user.valid?
  end

  test "validates using today as date" do
    User.validates_datetime :registered_at, after: :today

    user.registered_at = Time.now
    refute user.valid?

    user.registered_at = Date.today
    refute user.valid?

    user.registered_at = Date.tomorrow
    assert user.valid?

    user.registered_at = 1.day.from_now
    assert user.valid?
  end

  test "validates using now as date" do
    User.validates_datetime :registered_at, after: :now

    user.registered_at = Time.now
    refute user.valid?

    user.registered_at = Date.today
    refute user.valid?

    user.registered_at = Date.tomorrow
    assert user.valid?

    user.registered_at = 1.day.from_now
    assert user.valid?
  end

  test "validates using method as date" do
    User.validates_datetime :starts_at
    User.validates_datetime :ends_at, after: :starts_at, if: :starts_at?

    user.starts_at = nil
    user.ends_at = Time.now

    refute user.valid?
    assert user.errors[:ends_at].empty?

    user.starts_at = Time.parse("Apr 26 2010")
    user.ends_at = Time.parse("Apr 25 2010")
    formatted_date = I18n.l(Time.parse("Apr 26 2010"))

    refute user.valid?
    assert_includes user.errors[:ends_at], "needs to be after #{formatted_date}"

    user.starts_at = Time.now
    user.ends_at = 1.hour.from_now

    assert user.valid?
  end

  test "validates using proc as date" do
    User.validates_datetime :starts_at
    User.validates_datetime :ends_at, after: ->(record) { record.starts_at }, if: :starts_at?

    user.starts_at = nil
    user.ends_at = Time.now

    refute user.valid?
    assert user.errors[:ends_at].empty?

    user.starts_at = Time.parse("Apr 26 2010")
    user.ends_at = Time.parse("Apr 25 2010")
    formatted_date = I18n.l(Time.parse("Apr 26 2010"))

    refute user.valid?
    assert_includes user.errors[:ends_at], "needs to be after #{formatted_date}"

    user.starts_at = Time.now
    user.ends_at = 1.hour.from_now

    assert user.valid?
  end
end
