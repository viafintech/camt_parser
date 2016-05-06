require 'spec_helper'

describe CamtParser::Creditor do
  let(:camt)       { CamtParser::File.parse('spec/fixtures/053/valid_example.xml') }
  let(:statements) { camt.statements }
  let(:ex_stmt)    { camt.statements[0] }
  let(:entries)  { ex_stmt.entries }
  let(:ex_entry) { ex_stmt.entries[0] }
  let(:creditor) { ex_entry.creditor }

  specify { expect(creditor.name).to eq("Testkonto Nummer 2") }
  specify { expect(creditor.iban).to eq("DE09300606010012345671") }
  specify { expect(creditor.bic).to eq("DAAEDEDDXXX") }
  specify { expect(creditor.bank_name).to eq("Bank") }
end
