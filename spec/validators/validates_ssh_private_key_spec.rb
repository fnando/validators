require "spec_helper"

describe ".validates_ssh_private_key" do
  context "common" do
    let(:model) { Class.new {
      def self.name
        "User"
      end

      include ActiveModel::Model
      validates_ssh_private_key :key
      attr_accessor :key
    } }

    it "requires valid key" do
      record = model.new(key: "invalid")
      record.valid?

      expect(record.errors[:key]).not_to be_empty
    end

    it "accepts valid key" do
      record = model.new(key: SSHKey.generate.private_key)
      record.valid?

      expect(record.errors[:key]).to be_empty
    end

    it "sets translated error message" do
      I18n.locale = "pt-BR"
      message = "não é uma chave privada de SSH válida"

      record = model.new(key: "invalid")
      record.valid?

      expect(record.errors[:key]).to include(message)
    end
  end

  context "type validation (RSA)" do
    let(:model) { Class.new {
      def self.name
        "User"
      end

      include ActiveModel::Model
      validates_ssh_private_key :key, type: 'rsa'
      attr_accessor :key
    } }

    it "accepts rsa key" do
      record = model.new(key: SSHKey.generate(type: "rsa").private_key)
      record.valid?

      expect(record.errors[:key]).to be_empty
    end

    it "rejects dsa key" do
      record = model.new(key: SSHKey.generate(type: "dsa").private_key)
      record.valid?

      expect(record.errors[:key]).not_to be_empty
    end

    it "sets translated error message" do
      I18n.locale = "pt-BR"

      record = model.new(key: SSHKey.generate(type: "dsa").private_key)
      record.valid?

      expect(record.errors[:key]).to include("precisa ser uma chave RSA")
    end
  end

  context "type validation (DSA)" do
    let(:model) { Class.new {
      def self.name
        "User"
      end

      include ActiveModel::Model
      validates_ssh_private_key :key, type: "dsa"
      attr_accessor :key
    } }

    it "accepts dsa key" do
      record = model.new(key: SSHKey.generate(type: "dsa").private_key)
      record.valid?

      expect(record.errors[:key]).to be_empty
    end

    it "rejects rsa key" do
      record = model.new(key: SSHKey.generate(type: 'rsa').private_key)
      record.valid?

      expect(record.errors[:key]).not_to be_empty
    end

    it "sets translated error message" do
      I18n.locale = "pt-BR"

      record = model.new(key: SSHKey.generate(type: 'rsa').private_key)
      record.valid?

      expect(record.errors[:key]).to include("precisa ser uma chave DSA")
    end
  end

  context "bits" do
    let(:model) { Class.new {
      def self.name
        "User"
      end

      include ActiveModel::Model
      validates_ssh_private_key :key, bits: 2048
      attr_accessor :key
    } }

    it "accepts bits equals to required" do
      record = model.new(key: SSHKey.generate(bits: 2048).private_key)
      record.valid?

      expect(record.errors[:key]).to be_empty
    end

    it "accepts bits greater than required" do
      record = model.new(key: SSHKey.generate(bits: 4096).private_key)
      record.valid?

      expect(record.errors[:key]).to be_empty
    end

    it "rejects invalid bits" do
      record = model.new(key: SSHKey.generate(bits: 1024).private_key)
      record.valid?

      expect(record.errors[:key]).not_to be_empty
    end

    it "sets translated error message" do
      I18n.locale = "pt-BR"
      message = "precisa ter pelo menos 2048 bits; a sua chave tem 1024 bits"

      record = model.new(key: SSHKey.generate(bits: 1024).private_key)
      record.valid?

      expect(record.errors[:key]).to include(message)
    end
  end
end
