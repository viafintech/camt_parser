require 'spec_helper'

describe CamtParser::Format053::Base do

  context 'initialization' do
    after do
      CamtParser::File.parse 'spec/fixtures/valid_example.xml'
    end

    it { expect(CamtParser::Format053::GroupHeader).to receive(:new).and_call_original }
    it { expect(CamtParser::Format053::Statement).to receive(:new).and_call_original }
  end

  let(:camt) { CamtParser::File.parse 'spec/fixtures/valid_example.xml' }
  it { expect(camt.group_header).to_not be_nil }
  it { expect(camt.statements).to_not eq([]) }
end
