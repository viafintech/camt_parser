require 'spec_helper'

RSpec.describe CamtParser::Format054::Base do
  context 'initialization' do
    after do
      CamtParser::File.parse 'spec/fixtures/054/valid_example.xml'
    end

    specify { expect(CamtParser::GroupHeader).to receive(:new).and_call_original }
    specify { expect(CamtParser::Format054::Notification).to receive(:new).and_call_original }
  end

  let(:camt) { CamtParser::File.parse 'spec/fixtures/054/valid_example.xml' }
  specify { expect(camt.group_header).to_not be_nil }
  specify { expect(camt.notifications).to_not eq([]) }
end
