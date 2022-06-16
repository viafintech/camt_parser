require 'spec_helper'

RSpec.describe CamtParser::Creditor do
  let(:camt)           { CamtParser::File.parse('spec/fixtures/053/valid_example.xml') }
  let(:statements)     { camt.statements }
  let(:ex_stmt)        { statements[0] }
  let(:entries)        { ex_stmt.entries }
  let(:ex_entry)       { entries[0] }
  let(:transactions)   { ex_entry.transactions }
  let(:ex_transaction) { transactions[0] }
  let(:creditor)       { ex_transaction.creditor }

  specify { expect(creditor.name).to eq("Testkonto Nummer 2") }
  specify { expect(creditor.iban).to eq("DE09300606010012345671") }
  specify { expect(creditor.bic).to eq("DAAEDEDDXXX") }
  specify { expect(creditor.bank_name).to eq("Bank") }
end
