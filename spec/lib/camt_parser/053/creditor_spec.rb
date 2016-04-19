require 'spec_helper'

describe CamtParser::Format053::Creditor do
  let(:camt)       { CamtParser::File.parse('spec/fixtures/valid_example.xml') }
  let(:statements) { camt.statements }
  let(:ex_stmt)    { camt.statements[0] }
  let(:entries)  { ex_stmt.entries }
  let(:ex_entry) { ex_stmt.entries[0] }
  let(:creditor) { ex_entry.creditor }

  it { expect(creditor.name).to eq("Testkonto Nummer 2") }
  it { expect(creditor.iban).to eq("DE09300606010012345671") }
  it { expect(creditor.bic).to eq("DAAEDEDDXXX") }
  it { expect(creditor.bank_name).to eq("Bank") }
end
