require "spec_helper"

describe ".validates_ip_address" do
  subject { User.new }

  context "IPv4" do
    it "should be valid" do
      User.validates_ip_address :url, :only => :v4
      subject.url = "192.168.1.2"
      subject.should be_valid
    end

    it "should not be valid" do
      User.validates_ip_address :url, :only => :v4
      subject.url = "FE80:0000:0000:0000:0202:B3FF:FE1E:8329"
      subject.should_not be_valid
      subject.errors[:url].should == ["is not a valid IPv4 address"]
    end
  end

  context "IPv6" do
    it "should be valid" do
      User.validates_ip_address :url, :only => :v6
      subject.url = "FE80:0000:0000:0000:0202:B3FF:FE1E:8329"
      subject.should be_valid
    end

    it "should not be valid" do
      User.validates_ip_address :url, :only => :v6
      subject.url = "192.168.1.2"
      subject.should_not be_valid
      subject.errors[:url].should == ["is not a valid IPv6 address"]
    end
  end

  it "should be valid with IPv4" do
    User.validates_ip_address :url
    subject.url = "192.168.1.2"
    subject.should be_valid
  end

  it "should be valid with IPv6" do
    User.validates_ip_address :url
    subject.url = "FE80:0000:0000:0000:0202:B3FF:FE1E:8329"
    subject.should be_valid
  end

  it "should allow blank values" do
    User.validates_ip_address :url, :allow_blank => true
    subject.url = ""
    subject.should be_valid
  end

  it "should allow nil values" do
    User.validates_ip_address :url, :allow_nil => true
    subject.url = nil
    subject.should be_valid
  end
end
