require 'spec_helper'

RSpec.describe CamtParser::Format053::Base do

  context 'version 2' do
    context 'initialization' do
      after do
        CamtParser::File.parse 'spec/fixtures/053/valid_example.xml'
      end

      specify { expect(CamtParser::GroupHeader).to receive(:new).and_call_original }
      specify { expect(CamtParser::Format053::Statement).to receive(:new).and_call_original }
    end

    let(:camt) { CamtParser::File.parse 'spec/fixtures/053/valid_example.xml' }
    specify { expect(camt.group_header).to_not be_nil }
    specify { expect(camt.statements).to_not eq([]) }
  end

  context 'version 4' do
    context 'initialization' do
      after do
        CamtParser::File.parse 'spec/fixtures/053/valid_example_v4.xml'
      end

      specify { expect(CamtParser::GroupHeader).to receive(:new).and_call_original }
      specify { expect(CamtParser::Format053::Statement).to receive(:new).and_call_original }
    end

    let(:camt) { CamtParser::File.parse 'spec/fixtures/053/valid_example_v4.xml' }
    specify { expect(camt.group_header).to_not be_nil }
    specify { expect(camt.statements).to_not eq([]) }
  end
end
