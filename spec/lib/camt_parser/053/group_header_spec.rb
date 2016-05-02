require 'spec_helper'

describe CamtParser::Format053::GroupHeader do
  let(:camt) { CamtParser::File.parse 'spec/fixtures/053/valid_example.xml' }
  let(:group_header) { camt.group_header }

  specify { expect(group_header).to be_kind_of(described_class) }
  specify { expect(group_header.message_id).to eq("053D2013-12-27T22:05:03.0N130000005") }
  specify { expect(group_header.creation_date_time).to be_kind_of(Time) }
  specify { expect(group_header.message_pagination).to be_kind_of(CamtParser::Format053::MessagePagination) }
  specify { expect(group_header.additional_information).to eq("") }
end

describe CamtParser::Format053::MessagePagination do
  let(:camt) { CamtParser::File.parse 'spec/fixtures/053/valid_example.xml' }
  let(:message_pagination) { camt.group_header.message_pagination }

  specify { expect(message_pagination).to be_kind_of(described_class) }
  specify { expect(message_pagination.page_number).to eq(1) }
  specify { expect(message_pagination.last_page?).to be_truthy }
end
