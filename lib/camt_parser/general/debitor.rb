module CamtParser
  class Debitor

    attr_reader :xml_data

    def initialize(xml_data)
      @xml_data = xml_data
    end

    def name
      @name ||= [
        xml_data.xpath('RltdPties/Dbtr/Nm/text()').text,
        xml_data.xpath('RltdPties/Dbtr/Pty/Nm/text()').text,
      ].reject(&:empty?).first.to_s
    end

    def iban
      @iban ||= xml_data.xpath('RltdPties/DbtrAcct/Id/IBAN/text()').text
    end

    def bic
      @bic ||= [
        xml_data.xpath('RltdAgts/DbtrAgt/FinInstnId/BIC/text()').text,
        xml_data.xpath('RltdAgts/DbtrAgt/FinInstnId/BICFI/text()').text,
      ].reject(&:empty?).first.to_s
    end

    def bank_name
      @bank_name ||= xml_data.xpath('RltdAgts/DbtrAgt/FinInstnId/Nm/text()').text
    end
  end
end
