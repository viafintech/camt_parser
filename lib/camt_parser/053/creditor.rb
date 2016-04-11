module CamtParser
  module Format053
    class Creditor
      def initialize(xml_data)
        @xml_data = xml_data
      end

      def name
        @name ||= (x = @xml_data.xpath('TxDtls/RltdPties/Cdtr/Nm')).empty? ? nil : x.first.content
      end

      def iban
        @iban ||= (x = @xml_data.xpath('TxDtls/RltdPties/CdtrAcct/Id/IBAN')).empty? ? nil : x.first.content
      end

      def bic
        @bic ||= (x = @xml_data.xpath('TxDtls/RltdAgts/CdtrAgt/FinInstnId/BIC')).empty? ? nil : x.first.content
      end

      def bank_name
        @bank_name ||= (x = @xml_data.xpath('TxDtls/RltdAgts/CdtrAgt/FinInstnId/Nm')).empty? ? nil : x.first.content
      end
    end
  end
end
