# encoding: utf-8
require "spec_helper"

describe ".validates_url_format_of" do
  context "validating TLD" do
    it "rejects invalid TLD" do
      user = UserWithTLD.new('http://example.xy')
      expect(user).not_to be_valid
    end

    TLDs.each do |tld|
      it "accepts #{tld} as TLD" do
        user = UserWithTLD.new("http://example.#{tld}")
        expect(user).to be_valid
      end
    end
  end

  context "without validating TLD" do
    before do
      User.validates_url_format_of :url, :allow_blank => false
    end

    VALID_URLS.each do |url|
      it "accepts #{url.inspect} as a valid url" do
        user = User.new(:url => url)
        expect(user).to be_valid
      end
    end

    INVALID_URLS.each do |url|
      it "rejects #{url.inspect} as a valid url" do
        user = User.new(:url => url)
        expect(user).not_to be_valid
      end
    end

    it "defines alias method" do
      expect(User).to respond_to(:validates_url)
    end

    it "uses default error message" do
      user = User.new(:url => "invalid")
      expect(user).not_to be_valid
      expect(user.errors[:url]).to eq(["is not a valid address"])
    end

    it "uses I18n string as error message [pt-BR]" do
      I18n.locale = :'pt-BR'
      user = User.new(:url => "invalid")
      expect(user).not_to be_valid
      expect(user.errors[:url]).to eq(["não parece ser uma URL válida"])
    end
  end
end
