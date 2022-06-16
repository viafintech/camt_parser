require 'spec_helper'

RSpec.describe CamtParser::Charges do
  let(:camt)       { CamtParser::File.parse('spec/fixtures/053/valid_example_v4.xml') }
  let(:entries)  { camt.statements.first.entries }
  let(:ex_charges) { entries[6].charges }

  specify { expect(entries.map(&:charges)).to all(be_kind_of(described_class)) }
  specify { expect(ex_charges.total_charges_and_tax_amount).to eq(BigDecimal('5.2')) }
end
