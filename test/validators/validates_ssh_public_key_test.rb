# frozen_string_literal: true

require "test_helper"

class ValidatesSsshPublicKeyCommonTest < Minitest::Test
  let(:model) do
    Class.new do
      def self.name
        "User"
      end

      include ActiveModel::Model
      validates_ssh_public_key :key
      attr_accessor :key
    end
  end

  test "fails when sshkey is not available" do
    assert_raises(StandardError, /sshkey is not part of the bundle/) do
      Class.new do
        Validators.expects(:require).with("sshkey").raises(LoadError, "-- sshkey")

        include ActiveModel::Model
        validates_ssh_public_key :key
      end
    end
  end

  test "requires valid key" do
    record = model.new(key: nil)
    record.valid?

    refute record.errors[:key].empty?
  end

  test "accepts valid key" do
    record = model.new(key: SSHKey.generate.ssh_public_key)
    record.valid?

    assert record.errors[:key].empty?
  end

  test "sets translated error message" do
    I18n.locale = "pt-BR"
    message = "não é uma chave pública de SSH válida"

    record = model.new(key: "invalid")
    record.valid?

    assert_includes record.errors[:key], message
  end
end
