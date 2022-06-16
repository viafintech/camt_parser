require 'spec_helper'

RSpec.describe CamtParser::Format054::Notification do
  let(:camt)          { CamtParser::File.parse('spec/fixtures/054/valid_example.xml') }
  let(:notifications) { camt.notifications }
  let(:ex_ntfcn)      { camt.notifications[0] }

  specify { expect(notifications).to all(be_kind_of(described_class)) }
  specify { expect(ex_ntfcn.identification).to eq("20160410375204000131032") }
  specify { expect(ex_ntfcn.generation_date).to be_kind_of(Time) }
  specify { expect(ex_ntfcn.from_date_time).to be_kind_of(Time) }
  specify { expect(ex_ntfcn.to_date_time).to be_kind_of(Time) }
  specify { expect(ex_ntfcn.account).to be_kind_of(CamtParser::Account) }
  specify { expect(ex_ntfcn.entries).to be_kind_of(Array) }
end
