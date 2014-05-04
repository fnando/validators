# encoding: utf-8
require "spec_helper"

describe ".validates_email_format_of" do
  before do
    User.validates_email_format_of :email, :corporate_email, :allow_blank => false
    Buyer.validates_email_format_of :email, :message => "is not a valid e-mail"
    Person.validates :email, :email => true
  end

  VALID_EMAILS.each do |email|
    it "accepts #{email.inspect} as a valid email" do
      user = User.new(:email => email, :corporate_email => email)
      expect(user).to be_valid

      user = Person.new(:email => email)
      expect(user).to be_valid
    end
  end

  INVALID_EMAILS.each do |email|
    it "rejects #{email.inspect} as a valid email" do
      user = User.new(:email => "invalid", :corporate_email => "invalid")
      expect(user).not_to be_valid

      user = Person.new(:email => "invalid")
      expect(user).not_to be_valid
    end
  end

  it "uses default error message" do
    user = User.new(:email => "invalid")
    expect(user).not_to be_valid
    expect(user.errors[:email]).to eq(["is not a valid address"])
  end

  it "rejects nil value" do
    user = User.new(:email => nil)
    expect(user).not_to be_valid
    expect(user.errors[:email]).not_to be_empty
  end

  it "rejects empty value" do
    user = User.new(:email => "")
    expect(user).not_to be_valid
    expect(user.errors[:email]).not_to be_empty
  end

  it "validates multiple attributes" do
    user = User.new(:corporate_email => "invalid")
    expect(user).not_to be_valid
    expect(user.errors[:corporate_email]).to eq(["is not a valid address"])
  end

  it "uses custom error message as :message options" do
    buyer = Buyer.new(:email => "invalid")
    expect(buyer).not_to be_valid
    expect(buyer.errors[:email]).to eq(["is not a valid e-mail"])
  end

  it "uses I18n string as error message [pt-BR]" do
    I18n.locale = :'pt-BR'
    user = User.new(:email => "invalid")
    expect(user).not_to be_valid
    expect(user.errors[:email]).to eq(["não parece ser um e-mail válido"])
  end

  it "defines alias method" do
    expect(User).to respond_to(:validates_email)
  end
end
