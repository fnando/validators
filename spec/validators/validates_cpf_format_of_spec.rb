# encoding: utf-8
require 'spec_helper'

describe '.validates_cpf_format_of' do
  before do
    User.validates :cpf, :cpf => true
  end

  VALID_CPFS.each do |cpf|
    it "should accept #{cpf.inspect} as a valid cpf" do
      user = User.new(:cpf => cpf)
      user.should be_valid
    end
  end

  INVALID_CPFS.each do |cpf|
    it "should reject #{cpf.inspect} as a valid cpf" do
      user = User.new(:cpf => cpf)
      user.should_not be_valid
    end
  end

  it 'should use default error message' do
    user = User.new(:cpf => INVALID_CPFS.first)
    user.should_not be_valid
    user.errors[:cpf].should == ['is not a valid cpf number']
  end

  it 'should reject nil value' do
    user = User.new(:cpf => nil)
    user.should_not be_valid
    user.errors[:cpf].should_not be_empty
  end

  it 'should reject empty value' do
    user = User.new(:cpf => '')
    user.should_not be_valid
    user.errors[:cpf].should_not be_empty
  end

  it 'should use I18n string as error message [pt-BR]' do
    I18n.locale = :'pt-BR'
    user = User.new(:cpf => INVALID_CPFS.first)
    user.should_not be_valid
    user.errors[:cpf].should == ['não é um CPF válido']
  end

  it 'should have alias method' do
    User.should respond_to(:validates_cpf)
  end
end
