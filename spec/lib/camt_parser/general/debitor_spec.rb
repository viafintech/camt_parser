require 'spec_helper'

RSpec.describe CamtParser::Debitor do
  let(:camt)           { CamtParser::File.parse('spec/fixtures/053/valid_example.xml') }
  let(:statements)     { camt.statements }
  let(:ex_stmt)        { statements[0] }
  let(:entries)        { ex_stmt.entries }
  let(:ex_entry)       { entries[0] }
  let(:transactions)   { ex_entry.transactions }
  let(:ex_transaction) { transactions[0] }
  let(:debitor)        { ex_transaction.debitor }

  specify { expect(debitor.name).to eq("Wayne Enterprises") }
  specify { expect(debitor.iban).to eq("DE24302201900609832118") }
  specify { expect(debitor.bic).to eq("DAAEDEDDXXX") }
  specify { expect(debitor.bank_name).to eq("") }
end
