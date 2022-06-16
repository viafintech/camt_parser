require 'spec_helper'

RSpec.describe CamtParser::Record do
  let(:camt)       { CamtParser::File.parse('spec/fixtures/053/valid_example_v4.xml') }
  let(:ex_entry)  { camt.statements.first.entries[6] }
  let(:ex_charges) { ex_entry.charges }

  specify { expect(ex_charges.records).to all(be_kind_of(described_class)) }
  specify { expect(ex_charges.records[0].amount_in_cents).to be(540) }
  specify { expect(ex_charges.records[0].amount).to eq(BigDecimal('5.40')) }
  specify { expect(ex_charges.records[0].currency).to eq('CHF') }
  specify { expect(ex_charges.records[0].type).to be_kind_of(CamtParser::Type::Proprietary) }
  specify { expect(ex_charges.records[0].type.id).to eq('2') }
  specify { expect(ex_charges.records[0].credit?).to be(false) }
  specify { expect(ex_charges.records[0].charges_included?).to be(false) }

  specify { expect(ex_charges.records[1].amount_in_cents).to be(20) }
  specify { expect(ex_charges.records[1].amount).to eq(BigDecimal('0.20')) }
  specify { expect(ex_charges.records[1].currency).to eq('CHF') }
  specify { expect(ex_charges.records[1].type).to be_kind_of(CamtParser::Type::Code) }
  specify { expect(ex_charges.records[1].type.code).to eq('DISC') }
  specify { expect(ex_charges.records[1].credit?).to be(true) }
  specify { expect(ex_charges.records[1].charges_included?).to be(true) }
end
