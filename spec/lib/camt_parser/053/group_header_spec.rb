require 'spec_helper'

describe CamtParser::Format053::GroupHeader do
  it "parses the GroupHeader" do
    camt = CamtParser::File.parse 'spec/fixtures/valid_example.xml'
    group_header = camt.group_header
    expect(group_header.class).to eq(described_class)
    expect(group_header.message_id).to eq("053D2013-12-27T22:05:03.0N130000005")
    expect(group_header.creation_date_time.class).to eq(Time)
    expect(group_header.message_pagination.class).to eq(CamtParser::Format053::MessagePagination)
    expect(group_header.additional_information).to eq(nil)
  end
end

describe CamtParser::Format053::MessagePagination do
  it "parses the MessagePagination information" do
    camt = CamtParser::File.parse 'spec/fixtures/valid_example.xml'
    message_pagination = camt.group_header.message_pagination
    expect(message_pagination.class).to eq(described_class)
    expect(message_pagination.page_number).to eq(1)
    expect(message_pagination.last_page?).to eq(true)
  end
end
