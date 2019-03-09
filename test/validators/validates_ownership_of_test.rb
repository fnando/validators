# frozen_string_literal: true

require "test_helper"

class ValidatesOwnershipOfTest < Minitest::Test
  let(:user) { User.create! }
  let(:another_user) { User.create! }
  let(:category) { Category.create!(user: user) }
  let(:another_category) { Category.create!(user: another_user) }
  let(:task) { Task.new(user: user, category: category) }

  setup do
    user
    another_user
    category
    another_category
    task

    Task.validates_ownership_of :category, with: :user
  end

  test "is valid when record is owned by the correct user" do
    assert task.valid?
  end

  test "is invalid when record is owned by a different user" do
    task.category = another_category
    refute task.valid?
  end

  test "raises error without :with option" do
    assert_raises(ArgumentError) { Task.validates_ownership_of :category }
  end

  test "raises error when :with options is not a valid type" do
    assert_raises(ArgumentError) { Task.validates_ownership_of :category, with: user }
  end

  test "is invalid when owner is not present" do
    task.user = nil
    refute task.valid?
  end

  test "is invalid when attribute owner is not present" do
    task.category.user = nil
    refute task.valid?
  end

  test "is valid when both owners are nil" do
    task.category.user = nil
    task.user = nil

    assert task.valid?
  end

  test "is valid when attribute is nil" do
    task.category = nil
    assert task.valid?
  end

  test "sets error message" do
    task.user = nil

    refute task.valid?
    assert_includes task.errors[:category], "is not associated with your user"
  end
end
