module CamtParser
  module Format053
    class Entry
      def initialize(xml_data)
        @xml_data = xml_data
      end

      def amount
        @amount ||= BigDecimal.new(@xml_data.xpath('Amt/text()').text)
      end

      def currency
        @currency ||= @xml_data.xpath('Amt/@Ccy').text
      end

      def debit
        @debit ||= @xml_data.xpath('CdtDbtInd/text()').text.upcase == 'DBIT'
      end

      def value_date
        @value_date ||= Date.parse(@xml_data.xpath('ValDt/Dt/text()').text)
      end

      def creditor
        @creditor ||= Creditor.new(@xml_data.xpath('NtryDtls'))
      end

      def credit?
        !!@debit
      end

      def debitor
        @debitor ||= Debitor.new(@xml_data.xpath('NtryDtls'))
      end

      def debit?
        @debit
      end

      def additional_information
        @additional_information ||= @xml_data.xpath('AddtlNtryInf/text()').text
      end

      def remittance_information
        @remittance_information ||= begin
          if (x = @xml_data.xpath('NtryDtls/TxDtls/RmtInf/Ustrd')).empty?
            nil
          else
            x.collect(&:content).join(' ')
          end
        end
      end

      def name
        @debitor.name || @creditor.name
      end

      def iban
        @debitor.name || @creditor.name
      end

      def bic
        @debitor.bic || @creditor.bic
      end
    end
  end
end
