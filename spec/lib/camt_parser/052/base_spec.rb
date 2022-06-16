require 'spec_helper'

RSpec.describe CamtParser::Format052::Base do

  context 'initialization' do
    after do
      CamtParser::File.parse 'spec/fixtures/052/valid_example.xml'
    end

    specify { expect(CamtParser::GroupHeader).to receive(:new).and_call_original }
    specify { expect(CamtParser::Format052::Report).to receive(:new).and_call_original }
  end

  let(:camt) { CamtParser::File.parse 'spec/fixtures/052/valid_example.xml' }
  specify { expect(camt.group_header).to_not be_nil }
  specify { expect(camt.reports).to_not eq([]) }
end
