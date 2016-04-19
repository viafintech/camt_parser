require 'spec_helper'

describe CamtParser::Format053::Account do
  let(:camt)       { CamtParser::File.parse('spec/fixtures/valid_example.xml') }
  let(:statements) { camt.statements }
  let(:ex_stmt)    { camt.statements[0] }
  let(:account) { ex_stmt.account }

  it { expect(account.iban).to eq("DE14740618130000033626") }
  it { expect(account.iban).to eq(account.account_number) }
  it { expect(account.iban).to eq(account.source) }
  it { expect(account.bic).to eq("GENODEF1PFK") }
  it { expect(account.bank_name).to eq("VR-Bank Rottal-Inn eG") }
end

