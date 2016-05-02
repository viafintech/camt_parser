require 'spec_helper'

describe CamtParser::Format053::Account do
  let(:camt)       { CamtParser::File.parse('spec/fixtures/053/valid_example.xml') }
  let(:statements) { camt.statements }
  let(:ex_stmt)    { camt.statements[0] }
  let(:account) { ex_stmt.account }

  specify { expect(account.iban).to eq("DE14740618130000033626") }
  specify { expect(account.bic).to eq("GENODEF1PFK") }
  specify { expect(account.bank_name).to eq("VR-Bank Rottal-Inn eG") }
end

