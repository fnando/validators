require "test_helper"

class ValidatesCpfFormatOfTest < Minitest::Test
  let(:model) { Class.new {
    def self.name
      "User"
    end

    include ActiveModel::Model
    validates_cpf_format_of :document
    attr_accessor :document
  } }

  test "requires valid CPF" do
    record = model.new(document: "invalid")
    record.valid?

    refute record.errors[:document].empty?
  end

  test "accepts formatted CPF" do
    record = model.new(document: CPF.generate(true))
    record.valid?

    assert record.errors[:document].empty?
  end

  test "accepts stripped CPF" do
    record = model.new(document: CPF.generate)
    record.valid?

    assert record.errors[:document].empty?
  end

  test "sets translated error message" do
    I18n.locale = "pt-BR"

    record = model.new
    record.valid?

    assert_includes record.errors[:document], "não é um CPF válido"
  end
end
