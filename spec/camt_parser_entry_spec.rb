# frozen_string_literal: true

require 'rspec'
require 'date'
require_relative '../lib/camt_parser/general/entry'

RSpec.describe CamtParser::Entry do
  let(:xml_data) do
    Nokogiri::XML(<<~XML)
      <Ntry>
        <NtryRef>20231004460032/0000002</NtryRef>
        <Amt Ccy="EUR">3600.00</Amt>
        <CdtDbtInd>DBIT</CdtDbtInd>
        <RvslInd>false</RvslInd>
        <Sts>BOOK</Sts>
        <BookgDt>
          <Dt>2023-10-04</Dt>
        </BookgDt>
        <ValDt>
          <Dt>2023-10-04</Dt>
        </ValDt>
      </Ntry>
    XML
  end

  subject(:entry) { described_class.new(xml_data) }

  describe '#ntry_ref' do
    it 'returns the correct NtryRef value' do
      expect(entry.ntry_ref).to eq('20231004460032/0000002')
    end
  end
end
