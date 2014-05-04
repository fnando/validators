require "spec_helper"

describe ".validates_ip_address" do
  subject { User.new }

  context "IPv4" do
    it "is valid" do
      User.validates_ip_address :url, :only => :v4
      subject.url = "192.168.1.2"
      expect(subject).to be_valid
    end

    it "is invalid" do
      User.validates_ip_address :url, :only => :v4
      subject.url = "FE80:0000:0000:0000:0202:B3FF:FE1E:8329"
      expect(subject).not_to be_valid
      expect(subject.errors[:url]).to eq(["is not a valid IPv4 address"])
    end
  end

  context "IPv6" do
    it "is valid" do
      User.validates_ip_address :url, :only => :v6
      subject.url = "FE80:0000:0000:0000:0202:B3FF:FE1E:8329"
      expect(subject).to be_valid
    end

    it "is invalid" do
      User.validates_ip_address :url, :only => :v6
      subject.url = "192.168.1.2"
      expect(subject).not_to be_valid
      expect(subject.errors[:url]).to eq(["is not a valid IPv6 address"])
    end
  end

  it "is valid with IPv4" do
    User.validates_ip_address :url
    subject.url = "192.168.1.2"
    expect(subject).to be_valid
  end

  it "is valid with IPv6" do
    User.validates_ip_address :url
    subject.url = "FE80:0000:0000:0000:0202:B3FF:FE1E:8329"
    expect(subject).to be_valid
  end

  it "allows blank values" do
    User.validates_ip_address :url, :allow_blank => true
    subject.url = ""
    expect(subject).to be_valid
  end

  it "allows nil values" do
    User.validates_ip_address :url, :allow_nil => true
    subject.url = nil
    expect(subject).to be_valid
  end
end
