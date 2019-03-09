# frozen_string_literal: true

require "test_helper"

class RsaTest < Minitest::Test
  let(:model) do
    Class.new do
      def self.name
        "User"
      end

      include ActiveModel::Model
      validates_ssh_private_key :key, type: "rsa"
      attr_accessor :key
    end
  end

  test "accepts rsa key" do
    record = model.new(key: SSHKey.generate(type: "rsa").private_key)
    record.valid?

    assert record.errors[:key].empty?
  end

  test "rejects dsa key" do
    record = model.new(key: SSHKey.generate(type: "dsa").private_key)
    record.valid?

    refute record.errors[:key].empty?
  end

  test "sets translated error message" do
    I18n.locale = "pt-BR"

    record = model.new(key: SSHKey.generate(type: "dsa").private_key)
    record.valid?

    assert_includes record.errors[:key], "precisa ser uma chave RSA"
  end
end
