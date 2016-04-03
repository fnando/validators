require "test_helper"

class ValidatesDatetimeBeforeOptionTest < Minitest::Test
  let(:user) { User.new }

  test "rejects when date is set to after :before option" do
    User.validates_datetime :registered_at, :before => 1.week.ago
    user.registered_at = Time.now

    refute user.valid?
    assert_includes user.errors[:registered_at], "needs to be before #{I18n.l(1.week.ago)}"
  end

  test "accepts when date is set accordingly to the :before option" do
    User.validates_datetime :registered_at, :before => 1.week.ago
    user.registered_at = 2.weeks.ago

    assert user.valid?
  end
end
