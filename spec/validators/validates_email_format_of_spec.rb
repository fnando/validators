# encoding: utf-8
require "spec_helper"

describe ".validates_email_format_of" do
  before do
    User.validates_email_format_of :email, :corporate_email, :allow_blank => false
    Buyer.validates_email_format_of :email, :message => "is not a valid e-mail"
    Person.validates :email, :email => true
  end

  VALID_EMAILS.each do |email|
    it "should accept #{email.inspect} as a valid email" do
      user = User.new(:email => email, :corporate_email => email)
      user.should be_valid

      user = Person.new(:email => email)
      user.should be_valid
    end
  end

  INVALID_EMAILS.each do |email|
    it "should reject #{email.inspect} as a valid email" do
      user = User.new(:email => "invalid", :corporate_email => "invalid")
      user.should_not be_valid

      user = Person.new(:email => "invalid")
      user.should_not be_valid
    end
  end

  it "should use default error message" do
    user = User.new(:email => "invalid")
    user.should_not be_valid
    errors_for(user, :email).should == ["is not a valid address"]
  end

  it "should reject nil value" do
    user = User.new(:email => nil)
    user.should_not be_valid
    errors_for(user, :email).should_not be_empty
  end

  it "should reject empty value" do
    user = User.new(:email => "")
    user.should_not be_valid
    errors_for(user, :email).should_not be_empty
  end

  it "should validate multiple attributes" do
    user = User.new(:corporate_email => "invalid")
    user.should_not be_valid
    errors_for(user, :corporate_email).should == ["is not a valid address"]
  end

  it "should use custom error message as :message options" do
    buyer = Buyer.new(:email => "invalid")
    buyer.should_not be_valid
    errors_for(buyer, :email).should == ["is not a valid e-mail"]
  end

  it "should use I18n string as error message [pt-BR]" do
    I18n.locale = :'pt-BR'
    user = User.new(:email => "invalid")
    user.should_not be_valid
    errors_for(user, :email).should == ["não parece ser um e-mail válido"]
  end

  def errors_for(record, attr_name)
    record.errors[attr_name]
  end
end
