# encoding: utf-8
require "spec_helper"

describe ".validates_cep_format_of" do
  before do
    User.validates :zipcode, :cep => true
  end

  VALID_CEPS.each do |cep|
    it "should accept #{cep.inspect} as a valid cep" do
      user = User.new(:zipcode => cep)
      user.should be_valid
    end
  end

  INVALID_CEPS.each do |cep|
    it "should reject #{cep.inspect} as a valid cep" do
      user = User.new(:zipcode => cep)
      user.should_not be_valid
    end
  end

  it "should use default error message" do
    user = User.new(:zipcode => INVALID_CEPS.first)
    user.should_not be_valid
    user.errors[:zipcode].should == ["is not a valid cep number"]
  end

  it "should reject nil value" do
    user = User.new(:zipcode => nil)
    user.should_not be_valid
    user.errors[:zipcode].should_not be_empty
  end

  it "should reject empty value" do
    user = User.new(:zipcode => "")
    user.should_not be_valid
    user.errors[:zipcode].should_not be_empty
  end

  it "should use I18n string as error message [pt-BR]" do
    I18n.locale = :'pt-BR'
    user = User.new(:zipcode => INVALID_CEPS.first)
    user.should_not be_valid
    user.errors[:zipcode].should == ["não é um CEP válido"]
  end

  it "should have alias method" do
    User.should respond_to(:validates_cep)
  end
end
