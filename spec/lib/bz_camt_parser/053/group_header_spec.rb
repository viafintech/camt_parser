require 'spec_helper'

describe BzCamtParser::Format053::GroupHeader do
  it "parses the GroupHeader" do
    camt = BzCamtParser::File.parse 'spec/fixtures/valid_example.xml'
    group_header = camt.group_header
    expect(group_header.class).to eq(described_class)
    expect(group_header.message_id).to eq("ABCDEFG_YF0000_20150821A000000000")
    expect(group_header.creation_date_time.class).to eq(Time)
    expect(group_header.message_pagination.class).to eq(BzCamtParser::Format053::MessagePagination)
  end
end

describe BzCamtParser::Format053::MessagePagination do
  it "parses the MessagePagination information" do
    camt = BzCamtParser::File.parse 'spec/fixtures/valid_example.xml'
    message_pagination = camt.group_header.message_pagination
    expect(message_pagination.class).to eq(described_class)
    expect(message_pagination.page_number).to eq(1)
    expect(message_pagination.last_page?).to eq(true)
  end
end
