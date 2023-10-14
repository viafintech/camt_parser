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

    # @return [CamtParser::PostalAddress, nil]
    def postal_address # May be missing
      postal_address = [
        xml_data.xpath('RltdPties/Dbtr/PstlAdr'),
        xml_data.xpath('RltdPties/Dbtr/Pty/PstlAdr'),
      ].reject(&:empty?).first

      return nil if postal_address == nil || postal_address.empty?

      @address ||= CamtParser::PostalAddress.new(postal_address)
    end
  end
end
