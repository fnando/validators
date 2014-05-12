require "spec_helper"

describe ".validates_ssh_public_key" do
  context "common" do
    let(:model) { Class.new {
      def self.name
        "User"
      end

      include ActiveModel::Model
      validates_ssh_public_key :key
      attr_accessor :key
    } }

    it "requires valid key" do
      record = model.new(key: nil)
      record.valid?

      expect(record.errors[:key]).not_to be_empty
    end

    it "accepts valid key" do
      record = model.new(key: SSHKey.generate.ssh_public_key)
      record.valid?

      expect(record.errors[:key]).to be_empty
    end

    it "sets translated error message" do
      I18n.locale = "pt-BR"
      message = "não é uma chave pública de SSH válida"

      record = model.new(key: "invalid")
      record.valid?

      expect(record.errors[:key]).to include(message)
    end
  end
end
