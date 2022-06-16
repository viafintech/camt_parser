require 'spec_helper'

RSpec.describe CamtParser::Format052::Report do
  let(:camt)    { CamtParser::File.parse('spec/fixtures/052/valid_example.xml') }
  let(:reports) { camt.reports }
  let(:ex_rpt)  { camt.reports[0] }

  specify { expect(reports).to all(be_kind_of(described_class)) }
  specify { expect(ex_rpt.identification).to eq("0352C5220131227110203") }
  specify { expect(ex_rpt.generation_date).to be_kind_of(Time) }
  specify { expect(ex_rpt.account).to be_kind_of(CamtParser::Account) }
  specify { expect(ex_rpt.entries).to be_kind_of(Array) }

  specify { expect(ex_rpt.opening_balance).to be_kind_of(CamtParser::AccountBalance) }
  specify { expect(ex_rpt.closing_balance).to be_kind_of(CamtParser::AccountBalance) }

  specify { expect(ex_rpt.identification).to eq("0352C5220131227110203") }

  specify { expect(ex_rpt.from_date_time).to be_nil }
  specify { expect(ex_rpt.to_date_time).to be_nil }

  context 'Rpt/FrToDt' do
    let(:camt) { CamtParser::File.parse('spec/fixtures/052/valid_example_with_dates.xml') }

    specify { expect(ex_rpt.from_date_time).to be_kind_of(Time) }
    specify { expect(ex_rpt.from_date_time).to eq(Time.new(2013, 1, 1, 0, 0, 0)) }

    specify { expect(ex_rpt.to_date_time).to be_kind_of(Time) }
    specify { expect(ex_rpt.to_date_time).to eq(Time.new(2019, 8, 9, 0, 0, 0)) }
  end
end
