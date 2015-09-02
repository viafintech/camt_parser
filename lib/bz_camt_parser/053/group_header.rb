require 'time'

module BzCamtParser
  module Format053
    class GroupHeader
      attr_reader :message_id, :creation_date_time, :additional_information, :message_pagination

      def initialize(xml_data)
        @message_id             = xml_data.xpath('MsgId').first.content
        @creation_date_time     = Time.parse(xml_data.xpath('CreDtTm').first.content)
        @message_pagination     = (x = xml_data.xpath('MsgPgntn')).empty? ? nil : MessagePagination.new(x)
        @additional_information = (x = xml_data.xpath('AddtlInf')).empty? ? nil : x.first.content
      end
    end

    class MessagePagination
      attr_reader :page_number

      def initialize(xml_data)
        @page_number         = xml_data.xpath('PgNb').first.content.to_i
        @last_page_indicator = xml_data.xpath('LastPgInd').first.content == 'true'
      end

      def last_page?
        @last_page_indicator
      end
    end
  end
end
