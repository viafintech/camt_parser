require 'spec_helper'

describe CamtParser::Misc do
  let(:dot_value) { "30.12" }
  let(:comma_value) { "30,12" }

  context '#to_amount_in_cents' do
    specify { expect(described_class.to_amount_in_cents(dot_value)).to be_kind_of(Integer) }
    specify { expect(described_class.to_amount_in_cents(dot_value)).to eq(3012) }
    specify { expect(described_class.to_amount_in_cents(comma_value)).to eq(3012) }
  end

  context '#to_amount' do
    specify { expect(described_class.to_amount(dot_value)).to be_kind_of(BigDecimal) }
    specify { expect(described_class.to_amount(dot_value)).to eq(30.12) }
    specify { expect(described_class.to_amount(comma_value)).to eq(30.12) }
  end
end
