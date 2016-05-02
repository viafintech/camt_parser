require 'spec_helper'

describe CamtParser::Format053::Entry do
  let(:camt)       { CamtParser::File.parse('spec/fixtures/053/valid_example.xml') }
  let(:statements) { camt.statements }
  let(:ex_stmt)    { camt.statements[0] }
  let(:entries)  { ex_stmt.entries }
  let(:ex_entry) { ex_stmt.entries[0] }

  specify { expect(entries).to all(be_kind_of(described_class)) }

  context '#amount' do
    specify { expect(ex_entry.amount).to be_kind_of(BigDecimal) }
    specify { expect(ex_entry.amount).to eq(BigDecimal.new('2')) }
    specify { expect(ex_entry.amount_in_cents).to eq(200) }
  end

  specify { expect(ex_entry.currency).to eq('EUR') }
  specify { expect(ex_entry.value_date).to be_kind_of(Date) }
  specify { expect(ex_entry.value_date).to eq(Date.new(2013, 12, 27)) }
  specify { expect(ex_entry.booking_date).to be_kind_of(Date) }
  specify { expect(ex_entry.booking_date).to eq(Date.new(2013, 12, 27)) }
  specify { expect(ex_entry.creditor).to be_kind_of(CamtParser::Format053::Creditor) }
  specify { expect(ex_entry.debitor).to be_kind_of(CamtParser::Format053::Debitor) }
  specify { expect(ex_entry.remittance_information).to eq("TEST BERWEISUNG MITTELS BLZUND KONTONUMMER - DTA") }
  specify { expect(ex_entry.additional_information).to eq("Überweisungs-Gutschrift; GVC: SEPA Credit Transfer (Einzelbuchung-Haben)") }
  specify { expect(ex_entry.description).to eq(ex_entry.additional_information) }
  specify { expect(ex_entry.debit).to eq(true) }
  specify { expect(ex_entry.debit?).to eq(ex_entry.debit) }
  specify { expect(ex_entry.credit?).to eq(false) }
  specify { expect(ex_entry.sign).to eq(-1) }

  specify { expect(ex_entry.name).to eq("Testkonto Nummer 2") }
  specify { expect(ex_entry.iban).to eq("DE09300606010012345671") }
  specify { expect(ex_entry.bic).to eq("DAAEDEDDXXX") }
  specify { expect(ex_entry.swift_code).to eq("NTRF") }

  specify { expect(ex_entry.reference).to eq("") }
  specify { expect(ex_entry.bank_reference).to eq("BankReference") }
  specify { expect(ex_entry.end_to_end_reference).to eq("EndToEndReference") }
  specify { expect(ex_entry.mandate_reference).to eq("MandateReference") }
  specify { expect(ex_entry.transaction_id).to eq("UniqueTransactionId") }
  specify { expect(ex_entry.creditor_identifier).to eq("CreditorIdentifier") }
  specify { expect(ex_entry.payment_information).to eq("PaymentIdentification") }
end
