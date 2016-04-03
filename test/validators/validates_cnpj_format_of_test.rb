require "test_helper"

class ValidatesCnpjFormatOfTest < Minitest::Test
  let(:model) { Class.new {
    def self.name
      "User"
    end

    include ActiveModel::Model
    validates_cnpj_format_of :document
    attr_accessor :document
  } }

  test "requires valid CNPJ" do
    record = model.new(document: "invalid")
    record.valid?

    refute record.errors[:document].empty?
  end

  test "accepts formatted CNPJ" do
    record = model.new(document: CNPJ.generate(true))
    record.valid?

    assert record.errors[:document].empty?
  end

  test "accepts stripped CNPJ" do
    record = model.new(document: CNPJ.generate)
    record.valid?

    assert record.errors[:document].empty?
  end

  test "sets translated error message" do
    I18n.locale = "pt-BR"

    record = model.new
    record.valid?

    assert_includes record.errors[:document], "não é um CNPJ válido"
  end
end
