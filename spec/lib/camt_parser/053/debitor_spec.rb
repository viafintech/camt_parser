require 'spec_helper'

describe CamtParser::Format053::Debitor do
  let(:camt)       { CamtParser::File.parse('spec/fixtures/valid_example.xml') }
  let(:statements) { camt.statements }
  let(:ex_stmt)    { camt.statements[0] }
  let(:entries)  { ex_stmt.entries }
  let(:ex_entry) { ex_stmt.entries[0] }
  let(:debitor) { ex_entry.debitor }

  it { expect(debitor.name).to eq("Wayne Enterprises") }
  it { expect(debitor.iban).to eq("DE24302201900609832118") }
  it { expect(debitor.bic).to eq("DAAEDEDDXXX") }
  it { expect(debitor.bank_name).to eq("") }
end
