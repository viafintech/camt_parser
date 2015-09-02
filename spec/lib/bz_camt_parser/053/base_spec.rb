require 'spec_helper'

describe BzCamtParser::Format053::Base do
  it "parses the group_header and the statements" do
    expect(BzCamtParser::Format053::GroupHeader).to receive(:new).and_call_original
    expect(BzCamtParser::Format053::Statement).to receive(:new).and_call_original
    camt = BzCamtParser::File.parse 'spec/fixtures/valid_example.xml'
    expect(camt.group_header).to_not eq(nil)
    expect(camt.statements).to_not eq([])
  end
end
