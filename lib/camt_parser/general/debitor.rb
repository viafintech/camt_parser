module CamtParser
  class Debitor
    def initialize(xml_data)
      @xml_data = xml_data
    end

    def name
      @name ||= @xml_data.xpath('TxDtls/RltdPties/Dbtr/Nm/text()').text
    end

    def iban
      @iban ||= @xml_data.xpath('TxDtls/RltdPties/DbtrAcct/Id/IBAN/text()').text
    end

    def bic
      @bic ||= @xml_data.xpath('TxDtls/RltdAgts/DbtrAgt/FinInstnId/BIC/text()').text
    end

    def bank_name
      @bank_name ||= @xml_data.xpath('TxDtls/RltdAgts/DbtrAgt/FinInstnId/Nm/text()').text
    end
  end
end
