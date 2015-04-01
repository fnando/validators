require "spec_helper"

describe ".validates_hostname_format_of" do
  context "with TLD validation" do
    it 'rejects invalid TLD' do
      server = ServerWithTLD.new('example.xy')
      expect(server).not_to be_valid
    end

    it 'rejects only host label' do
      server = ServerWithTLD.new('com')
      expect(server).not_to be_valid
    end

    TLDs.each do |tld|
      it "accepts #{tld} as TLD" do
        server = ServerWithTLD.new("example.#{tld}")
        expect(server).to be_valid
      end
    end
  end

  context "without TLD validation" do
    VALID_HOSTNAMES.each do |host|
      it "accepts #{host}" do
        server = ServerWithoutTLD.new(host)
        expect(server).to be_valid
      end
    end

    INVALID_HOSTNAMES.each do |host|
      it "rejects #{host}" do
        server = ServerWithoutTLD.new(host)
        expect(server).not_to be_valid
      end
    end
  end
end
