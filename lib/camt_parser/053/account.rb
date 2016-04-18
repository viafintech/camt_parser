module CamtParser
  module Format053
    class Account
      def initialize(xml_data)
        @xml_data = xml_data
      end

      def iban
        @iban ||= (x = @xml_data.xpath('Id/IBAN')).empty? ? nil : x.first.content
      end
      alias_method :account_number, :iban
      alias_method :source, :iban

      def bic
        @bic ||= (x = @xml_data.xpath('Svcr/FinInstnId/BIC')).empty? ? nil : x.first.content
      end

      def bank_name
        @bank_name ||= (x = @xml_data.xpath('Svcr/FinInstnId/Nm')).empty? ? nil : x.first.content
      end
    end
  end
end
