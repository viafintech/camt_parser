require 'spec_helper'

RSpec.describe CamtParser::Transaction do
  context 'version 2' do
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
      specify { expect(ex_transaction.amount).to eq(BigDecimal('2')) }
      specify { expect(ex_transaction.amount_in_cents).to eq(200) }

      context 'AmtDtls/InstdAmt' do
        let(:camt) { CamtParser::File.parse('spec/fixtures/053/valid_example_with_instdamt.xml') }
        specify { expect(ex_transaction.amount).to eq(BigDecimal('4500')) }
        specify { expect(ex_transaction.amount_in_cents).to eq(450000) }
      end
    end

    context '#currency' do
      specify { expect(ex_transaction.currency).to eq('EUR') }

      context 'AmtDtls/InstdAmt' do
        let(:camt) { CamtParser::File.parse('spec/fixtures/053/valid_example_with_instdamt.xml') }
        specify { expect(ex_transaction.currency).to eq('CHF') }
      end
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
    specify {
      expect(ex_transaction.additional_information).to eq("AdditionalTransactionInformation")
    }
  end

  context 'version 4' do
    let(:camt)       { CamtParser::File.parse('spec/fixtures/053/valid_example_v4.xml') }
    let(:statements) { camt.statements }
    let(:ex_stmt)    { statements[0] }
    let(:entries)  { ex_stmt.entries }
    let(:ex_entry) { entries[6] }
    let(:transactions)   { ex_entry.transactions }
    let(:ex_transaction) { transactions[0] }

    context '#amount' do
      specify { expect(ex_transaction.amount).to be_kind_of(BigDecimal) }
      specify { expect(ex_transaction.amount).to eq(BigDecimal('100')) }
      specify { expect(ex_transaction.amount_in_cents).to eq(10000) }
    end

    context '#reason_code' do
      let(:ex_entry) { entries[12] }

      specify { expect(ex_transaction.reason_code).to eq("MD06") }
    end

    specify { expect(ex_transaction.creditor_reference).to eq("CreditorReference") }
  end
end
