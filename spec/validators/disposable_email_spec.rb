require "spec_helper"

describe ".validates_email_format_of" do
  context "when using disposable e-mail" do
    before do
      User.validates_email_format_of :email
    end

    DISPOSABLE_EMAILS.each do |domain|
      it "rejects disposable e-mail (#{domain})" do
        user = User.new(email: "user@#{domain}")
        user.valid?

        expect(user.errors[:email]).to include(I18n.t('activerecord.errors.messages.disposable_email'))
      end
    end
  end

  context "disable disposable e-mail" do
    before do
      User.validates_email_format_of :email, disposable: true
    end

    it "accepts e-mail" do
      user = User.new(email: "user@mailinator.com")
      user.valid?

      expect(user.errors[:email]).to be_empty
    end
  end
end
