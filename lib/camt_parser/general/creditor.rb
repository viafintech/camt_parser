module CamtParser
  class Creditor
    def initialize(xml_data)
      @xml_data = xml_data
    end

    def name
      @name ||= [
        @xml_data.xpath('RltdPties/Cdtr/Nm/text()').text,
        @xml_data.xpath('RltdPties/Cdtr/Pty/Nm/text()').text,
      ].reject(&:empty?).first.to_s
    end

    def iban
      @iban ||= @xml_data.xpath('RltdPties/CdtrAcct/Id/IBAN/text()').text
    end

    def bic
      @bic ||= [
        @xml_data.xpath('RltdAgts/CdtrAgt/FinInstnId/BIC/text()').text,
        @xml_data.xpath('RltdAgts/DbtrAgt/FinInstnId/BICFI/text()').text,
      ].reject(&:empty?).first.to_s
    end

    def bank_name
      @bank_name ||= @xml_data.xpath('RltdAgts/CdtrAgt/FinInstnId/Nm/text()').text
    end
  end
end
