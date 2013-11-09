require "spec_helper"

describe ".validates_cpf_format_of" do
  let(:model) { Class.new {
    def self.name
      "User"
    end

    include ActiveModel::Model
    validates_cpf_format_of :document
    attr_accessor :document
  } }

  it "requires valid CPF" do
    record = model.new(document: "invalid")
    record.valid?

    expect(record.errors[:document]).not_to be_empty
  end

  it "accepts formatted CPF" do
    record = model.new(document: CPF.generate(true))
    record.valid?

    expect(record.errors[:document]).to be_empty
  end

  it "accepts stripped CPF" do
    record = model.new(document: CPF.generate)
    record.valid?

    expect(record.errors[:document]).to be_empty
  end

  it "sets translated error message" do
    I18n.locale = "pt-BR"

    record = model.new
    record.valid?

    expect(record.errors[:document]).to include("não é um CPF válido")
  end
end
