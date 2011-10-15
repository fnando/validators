require "spec_helper"

describe "Validators::Cep" do
  VALID_CEPS.each do |cep_number|
    it "should accept #{cep_number} as a valid cep" do
      Validators::Cep.valid?(cep_number).should be_true
    end
  end

  INVALID_CEPS.each do |cep_number|
    it "should reject #{cep_number} as a valid cep" do
      Validators::Cep.valid?(cep_number).should be_false
    end
  end
end
