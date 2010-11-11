# encoding: utf-8
require "spec_helper"

describe ".validates_url_format_of" do
  before do
    User.validates_url_format_of :url, :allow_blank => false
  end

  VALID_URLS.each do |url|
    it "should accept #{url.inspect} as a valid url" do
      user = User.new(:url => url)
      user.should be_valid
    end
  end

  INVALID_URLS.each do |url|
    it "should reject #{url.inspect} as a valid url" do
      user = User.new(:url => url)
      user.should_not be_valid
    end
  end

  it "should have alias method" do
    User.should respond_to(:validates_url)
  end

  it "should use default error message" do
    user = User.new(:url => "invalid")
    user.should_not be_valid
    user.errors[:url].should == ["is not a valid address"]
  end

  it "should use I18n string as error message [pt-BR]" do
    I18n.locale = :'pt-BR'
    user = User.new(:url => "invalid")
    user.should_not be_valid
    user.errors[:url].should == ["não parece ser uma URL válida"]
  end
end
