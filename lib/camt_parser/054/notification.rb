module CamtParser
  module Format054
    class Notification

      attr_reader :xml_data

      def initialize(xml_data)
        @xml_data = xml_data
      end

      # @return [String]
      def identification
        @identification ||= xml_data.xpath('Id/text()').text
      end

      # @return [Time]
      def generation_date
        @generation_date ||= Time.parse(xml_data.xpath('CreDtTm/text()').text)
      end

      # @return [Time, nil]
      def from_date_time
        @from_date_time ||= (x = xml_data.xpath('FrToDt/FrDtTm')).empty? ? nil : Time.parse(x.first.content)
      end

      # @return [Time, nil]
      def to_date_time
        @to_date_time ||= (x = xml_data.xpath('FrToDt/ToDtTm')).empty? ? nil : Time.parse(x.first.content)
      end

      # @return [Account]
      def account
        @account ||= Account.new(xml_data.xpath('Acct').first)
      end

      # @return [Array<Entry>]
      def entries
        @entries ||= xml_data.xpath('Ntry').map{ |x| Entry.new(x) }
      end

      # @return [String]
      def source
        xml_data.to_s
      end

      # @return [CamtParser::Format054::Notification]
      def self.parse(xml)
        self.new Nokogiri::XML(xml).xpath('Ntfctn')
      end
    end
  end
end
