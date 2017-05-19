module CamtParser
  class Charges
    class Record
      def initialize(xml_data)
        @xml_data = xml_data
        @amount = @xml_data.xpath('Amt/text()').text
      end

      def amount
        CamtParser::Misc.to_amount(@amount)
      end

      def amount_in_cents
        CamtParser::Misc.to_amount_in_cents(@amount)
      end

      def currency
        @currency ||= @xml_data.xpath('Amt/@Ccy').text
      end

      def type
        @type ||= if @xml_data.xpath('Tp/Prtry').any?
          CamtParser::Types::Proprietary.new(@xml_data.xpath('Tp/Prtry/Id/text()').text)
        elsif @xml_data.xpath('Tp/Cd').any?
          CamtParser::Types::Code.new(@xml_data.xpath('Tp/Cd/text()').text)
        else
          CamtParser::Types::Nil.new
        end
      end

      def charges_included?
        @charges_included ||= @xml_data.xpath('ChrgInclInd/text()').text.downcase == 'true'
      end

      def debit
        @debit ||= @xml_data.xpath('CdtDbtInd/text()').text.upcase == 'DBIT'
      end

      def credit?
        !debit
      end

      def debit?
        debit
      end

      def sign
        credit? ? 1 : -1
      end
    end
  end
end