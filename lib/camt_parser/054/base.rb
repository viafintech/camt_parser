module CamtParser
  module Format054
    class Base
      attr_reader :group_header, :notifications, :xml_data

      def initialize(xml_data)
        @xml_data = xml_data

        grphdr = xml_data.xpath('BkToCstmrDbtCdtNtfctn/GrpHdr')
        @group_header = GroupHeader.new(grphdr)
        notifications = xml_data.xpath('BkToCstmrDbtCdtNtfctn/Ntfctn')
        @notifications = notifications.map{ |x| Notification.new(x) }
      end
    end
  end
end
