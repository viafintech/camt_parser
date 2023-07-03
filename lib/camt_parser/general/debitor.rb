module CamtParser
  class Debitor
    def initialize(xml_data)
      @xml_data = xml_data
    end

    def name
      @name ||= @xml_data.xpath('RltdPties/Dbtr/Nm/text()').text.then do |name|
        if name.empty?
          @xml_data.xpath('RltdPties/Dbtr/Pty/Nm/text()').text
        else
          name
        end
      end
    end

    def iban
      @iban ||= @xml_data.xpath('RltdPties/DbtrAcct/Id/IBAN/text()').text
    end

    def bic
      @bic ||= @xml_data.xpath('RltdAgts/DbtrAgt/FinInstnId/BIC/text()').text.then do |bic|
        if bic.empty?
          @xml_data.xpath('RltdAgts/DbtrAgt/FinInstnId/BICFI/text()').text
        else
          bic
        end
      end
    end

    def bank_name
      @bank_name ||= @xml_data.xpath('RltdAgts/DbtrAgt/FinInstnId/Nm/text()').text
    end
  end
end
