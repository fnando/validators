require "spec_helper"

describe Validators::Ip do
  context "IPv4" do
    VALID_IPV4.each do |ip|
      it "should accept #{ip.inspect} as ip address" do
        Validators::Ip.should be_v4(ip)
      end
    end
  end

  context "IPv6" do
    VALID_IPV6.each do |ip|
      it "should accept #{ip.inspect} as ip address" do
        Validators::Ip.should be_v6(ip)
      end
    end
  end

  (VALID_IPV4 + VALID_IPV6).each do |ip|
    it "should accept #{ip.inspect} as ip address" do
      Validators::Ip.should be_valid(ip)
    end
  end
end
