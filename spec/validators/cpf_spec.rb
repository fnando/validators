require "spec_helper"

describe "Validators::Cpf" do
  VALID_CPFS.each do |cpf_number|
    it "should accept #{cpf_number} as a valid cpf" do
      Validators::Cpf.valid?(cpf_number).should be_true
    end
  end

  INVALID_CPFS.each do |cpf_number|
    it "should reject #{cpf_number} as a valid cpf" do
      Validators::Cpf.valid?(cpf_number).should be_false
    end
  end
end
