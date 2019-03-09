# frozen_string_literal: true

require "test_helper"

class DisposableEmailTest < Minitest::Test
  DISPOSABLE_EMAILS.each do |domain|
    test "rejects disposable e-mail (#{domain})" do
      User.validates_email_format_of :email

      user = User.new(email: "user@#{domain}")
      user.valid?

      assert_includes user.errors[:email], I18n.t("activerecord.errors.messages.disposable_email")
    end
  end

  test "accepts disposable e-mail" do
    User.validates_email_format_of :email, disposable: true

    user = User.new(email: "user@mailinator.com")
    user.valid?

    assert user.errors[:email].empty?
  end
end
