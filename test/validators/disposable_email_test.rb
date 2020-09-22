# frozen_string_literal: true

require "test_helper"

class DisposableEmailTest < Minitest::Test
  DISPOSABLE_DOMAINS.each do |domain|
    test "rejects disposable domain (#{domain})" do
      User.validates_email_format_of :email

      user = User.new(email: "user@#{domain}")
      user.valid?

      assert_includes user.errors[:email],
                      I18n.t("activerecord.errors.messages.disposable_domain")
    end
  end

  DISPOSABLE_DOMAINS.each do |domain|
    test "rejects disposable e-mail with subdomain (custom.#{domain})" do
      User.validates_email_format_of :email

      user = User.new(email: "user@custom.#{domain}")
      user.valid?

      assert_includes user.errors[:email],
                      I18n.t("activerecord.errors.messages.disposable_domain")
    end
  end

  test "accepts disposable e-mail" do
    User.validates_email_format_of :email, disposable: true

    user = User.new(email: "user@mailinator.com")
    user.valid?

    assert user.errors[:email].empty?
  end

  DISPOSABLE_EMAILS.each do |email|
    test "rejects disposable e-mail (#{email})" do
      User.validates_email_format_of :email

      user = User.new(email: email)
      user.valid?

      assert_includes user.errors[:email],
                      I18n.t("activerecord.errors.messages.disposable_email")
    end
  end
end
