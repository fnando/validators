# frozen_string_literal: true

require "test_helper"

class ValidatesCpfFormatOfTest < Minitest::Test
  let(:model) do
    Class.new do
      def self.name
        "User"
      end

      include ActiveModel::Model
      validates_cpf_format_of :document
      attr_accessor :document
    end
  end

  test "fails when cpf_cnpj is not available" do
    assert_raises(StandardError, /cpf_cnpj is not part of the bundle/) do
      Class.new do
        Validators.expects(:require).with("cpf_cnpj").raises(LoadError, "-- cpf_cnpj")

        include ActiveModel::Model
        validates_cpf_format_of :document
      end
    end
  end

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
