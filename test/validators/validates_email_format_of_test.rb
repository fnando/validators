require "test_helper"

class ValidatesEmailFormatOfTest < Minitest::Test
  setup do
    User.validates_email_format_of :email, :corporate_email, :allow_blank => false
    Buyer.validates_email_format_of :email, :message => "is not a valid e-mail"
    Person.validates :email, :email => true
  end

  VALID_EMAILS.each do |email|
    test "accepts #{email.inspect} as a valid email" do
      user = User.new(:email => email, :corporate_email => email)
      assert user.valid?

      user = Person.new(:email => email)
      assert user.valid?
    end
  end

  INVALID_EMAILS.each do |email|
    test "rejects #{email.inspect} as a valid email" do
      user = User.new(:email => email, :corporate_email => email)
      refute user.valid?

      user = Person.new(:email => email)
      refute user.valid?
    end
  end

  test "uses default error message" do
    user = User.new(:email => "invalid")

    refute user.valid?
    assert_includes user.errors[:email], "is not a valid address"
  end

  test "rejects nil value" do
    user = User.new(:email => nil)

    refute user.valid?
    refute user.errors[:email].empty?
  end

  test "rejects empty value" do
    user = User.new(:email => "")

    refute user.valid?
    refute user.errors[:email].empty?
  end

  test "validates multiple attributes" do
    user = User.new(:corporate_email => "invalid")

    refute user.valid?
    assert_includes user.errors[:corporate_email], "is not a valid address"
  end

  test "uses custom error message as :message options" do
    buyer = Buyer.new(:email => "invalid")

    refute buyer.valid?
    assert_includes buyer.errors[:email], "is not a valid e-mail"
  end

  test "uses I18n string as error message [pt-BR]" do
    I18n.locale = :'pt-BR'
    user = User.new(:email => "invalid")

    refute user.valid?
    assert_includes user.errors[:email], "não parece ser um e-mail válido"
  end

  test "defines alias method" do
    assert User.respond_to?(:validates_email)
  end
end
