require 'spec_helper'

describe CamtParser::Format053::Base do
  it "parses the group_header and the statements" do
    expect(CamtParser::Format053::GroupHeader).to receive(:new).and_call_original
    expect(CamtParser::Format053::Statement).to receive(:new).and_call_original
    camt = CamtParser::File.parse 'spec/fixtures/valid_example.xml'
    expect(camt.group_header).to_not eq(nil)
    expect(camt.statements).to_not eq([])
  end
end
