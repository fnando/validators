require "spec_helper"

describe "Validators::Cnpj" do
  VALID_CNPJS.each do |cnpj_number|
    it "should accept #{cnpj_number} as a valid cnpj" do
      Validators::Cnpj.valid?(cnpj_number).should be_true
    end
  end

  INVALID_CNPJS.each do |cnpj_number|
    it "should reject #{cnpj_number} as a valid cnpj" do
      Validators::Cnpj.valid?(cnpj_number).should be_false
    end
  end
end
