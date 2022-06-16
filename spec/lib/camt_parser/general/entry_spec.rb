require 'spec_helper'

RSpec.describe CamtParser::Entry do
  let(:camt)       { CamtParser::File.parse('spec/fixtures/053/valid_example.xml') }
  let(:statements) { camt.statements }
  let(:ex_stmt)    { camt.statements[0] }
  let(:entries)  { ex_stmt.entries }
  let(:ex_entry) { ex_stmt.entries[0] }

  specify { expect(entries).to all(be_kind_of(described_class)) }

  context '#amount' do
    specify { expect(ex_entry.amount).to be_kind_of(BigDecimal) }
    specify { expect(ex_entry.amount).to eq(BigDecimal('2')) }
    specify { expect(ex_entry.amount_in_cents).to eq(200) }
  end

  specify { expect(ex_entry.currency).to eq('EUR') }
  specify { expect(ex_entry.value_date).to be_kind_of(Date) }
  specify { expect(ex_entry.value_date).to eq(Date.new(2013, 12, 27)) }
  specify { expect(ex_entry.booking_date).to be_kind_of(Date) }
  specify { expect(ex_entry.booking_date).to eq(Date.new(2013, 12, 27)) }
  specify { expect(ex_entry.additional_information).to eq('Überweisungs-Gutschrift; GVC: SEPA Credit Transfer (Einzelbuchung-Haben)') }
  specify { expect(ex_entry.description).to eq(ex_entry.additional_information) }
  specify { expect(ex_entry.debit).to eq(true) }
  specify { expect(ex_entry.debit?).to eq(ex_entry.debit) }
  specify { expect(ex_entry.credit?).to eq(false) }
  specify { expect(ex_entry.sign).to eq(-1) }
  specify { expect(ex_entry.transactions).to all(be_kind_of(CamtParser::Transaction)) }
  specify { expect(ex_entry.bank_reference).to eq('2013122710583450000') }
end
