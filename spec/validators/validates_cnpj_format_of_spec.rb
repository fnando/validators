# encoding: utf-8
require "spec_helper"

describe ".validates_cnpj_format_of" do
  before do
    Company.validates :cnpj, :cnpj => true
  end

  VALID_CNPJS.each do |cnpj|
    it "should accept #{cnpj.inspect} as a valid cnpj" do
      user = Company.new(:cnpj => cnpj)
      user.should be_valid
    end
  end

  INVALID_CNPJS.each do |cnpj|
    it "should reject #{cnpj.inspect} as a valid cnpj" do
      user = Company.new(:cnpj => cnpj)
      user.should_not be_valid
    end
  end

  it "should use default error message" do
    user = Company.new(:cnpj => INVALID_CNPJS.first)
    user.should_not be_valid
    user.errors[:cnpj].should == ["is not a valid cnpj number"]
  end

  it "should reject nil value" do
    user = Company.new(:cnpj => nil)
    user.should_not be_valid
    user.errors[:cnpj].should_not be_empty
  end

  it "should reject empty value" do
    user = Company.new(:cnpj => "")
    user.should_not be_valid
    user.errors[:cnpj].should_not be_empty
  end

  it "should use I18n string as error message [pt-BR]" do
    I18n.locale = :'pt-BR'
    user = Company.new(:cnpj => INVALID_CNPJS.first)
    user.should_not be_valid
    user.errors[:cnpj].should == ["não é um CNPJ válido"]
  end

  it "should have alias method" do
    Company.should respond_to(:validates_cnpj)
  end
end
