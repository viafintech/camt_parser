module CamtParser
  module Format053
    class Statement
      def initialize(xml_data)
        @xml_data = xml_data
      end

      def identification
        @identification ||= (x = @xml_data.xpath('Id')).empty? ? nil : x.first.content
      end

      def generation_date
        @generation_date ||= Time.parse(@xml_data.xpath('CreDtTm/text()').text)
      end

      def from_date_time
        @from_date_time ||= (x = @xml_data.xpath('FrToDt/FrDtTm')).empty? ? nil : Time.parse(x.first.content)
      end

      def to_date_time
        @to_date_time ||= (x = @xml_data.xpath('FrToDt/ToDtTm')).empty? ? nil : Time.parse(x.first.content)
      end

      def account
        @account ||= Account.new(@xml_data.xpath('Acct').first)
      end

      def entries
        @entries ||= @xml_data.xpath('Ntry').map{ |x| Entry.new(x) }
      end
    end
  end
end
