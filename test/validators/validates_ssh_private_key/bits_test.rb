# frozen_string_literal: true

require "test_helper"

class BitsTest < Minitest::Test
  let(:model) do
    Class.new do
      def self.name
        "User"
      end

      include ActiveModel::Model
      validates_ssh_private_key :key, bits: 2048
      attr_accessor :key
    end
  end

  test "accepts bits equals to required" do
    record = model.new(key: SSHKey.generate(bits: 2048).private_key)
    record.valid?

    assert record.errors[:key].empty?
  end

  test "accepts bits greater than required" do
    record = model.new(key: SSHKey.generate(bits: 4096).private_key)
    record.valid?

    assert record.errors[:key].empty?
  end

  test "rejects invalid bits" do
    record = model.new(key: SSHKey.generate(bits: 1024).private_key)
    record.valid?

    refute record.errors[:key].empty?
  end

  test "sets translated error message" do
    I18n.locale = "pt-BR"
    message = "precisa ter pelo menos 2048 bits; a sua chave tem 1024 bits"

    record = model.new(key: SSHKey.generate(bits: 1024).private_key)
    record.valid?

    assert_includes record.errors[:key], message
  end
end
