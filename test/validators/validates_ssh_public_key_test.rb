require "test_helper"

class ValidatesSsshPublicKeyCommonTest < Minitest::Test
  let(:model) { Class.new {
    def self.name
      "User"
    end

    include ActiveModel::Model
    validates_ssh_public_key :key
    attr_accessor :key
  } }

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
