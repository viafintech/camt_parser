module CamtParser
  module Format052
    class Base
      attr_reader :group_header, :reports, :xml_data

      def initialize(xml_data)
        @xml_data = xml_data
        # BkToCstmrAccptRpt = Bank to Customer Account Report
        grphdr = xml_data.xpath('BkToCstmrAcctRpt/GrpHdr')
        @group_header = CamtParser::GroupHeader.new(grphdr)
        reports = xml_data.xpath('BkToCstmrAcctRpt/Rpt')
        @reports = reports.map{ |x| Report.new(x) }
      end
    end
  end
end
