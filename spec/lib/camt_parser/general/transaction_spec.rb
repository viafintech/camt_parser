require 'spec_helper'

describe CamtParser::Transaction do
  let(:camt)       { CamtParser::File.parse('spec/fixtures/053/valid_example.xml') }
  let(:statements) { camt.statements }
  let(:ex_stmt)    { statements[0] }
  let(:entries)  { ex_stmt.entries }
  let(:ex_entry) { entries[0] }
  let(:transactions)   { ex_entry.transactions }
  let(:ex_transaction) { transactions[0] }

  specify { expect(transactions).to all(be_kind_of(described_class)) }

  context '#amount' do
    specify { expect(ex_transaction.amount).to be_kind_of(BigDecimal) }
    specify { expect(ex_transaction.amount).to eq(BigDecimal.new('2')) }
    specify { expect(ex_transaction.amount_in_cents).to eq(200) }
  end

  specify { expect(ex_transaction.currency).to eq('EUR') }
  specify { expect(ex_transaction.debit).to eq(true) }
  specify { expect(ex_transaction.debit?).to eq(ex_transaction.debit) }
  specify { expect(ex_transaction.credit?).to eq(false) }
  specify { expect(ex_transaction.sign).to eq(-1) }

  specify { expect(ex_transaction.creditor).to be_kind_of(CamtParser::Creditor) }
  specify { expect(ex_transaction.debitor).to be_kind_of(CamtParser::Debitor) }
  specify { expect(ex_transaction.remittance_information)
    .to eq("TEST BERWEISUNG MITTELS BLZUND KONTONUMMER - DTA") }
  specify { expect(ex_transaction.iban).to eq("DE09300606010012345671") }
  specify { expect(ex_transaction.bic).to eq("DAAEDEDDXXX") }
  specify { expect(ex_transaction.swift_code).to eq("NTRF") }
  specify { expect(ex_transaction.reference).to eq("") }
  specify { expect(ex_transaction.bank_reference).to eq("BankReference") }
  specify { expect(ex_transaction.end_to_end_reference).to eq("EndToEndReference") }
  specify { expect(ex_transaction.mandate_reference).to eq("MandateReference") }
  specify { expect(ex_transaction.transaction_id).to eq("UniqueTransactionId") }
  specify { expect(ex_transaction.creditor_identifier).to eq("CreditorIdentifier") }
  specify { expect(ex_transaction.payment_information).to eq("PaymentIdentification") }
end
