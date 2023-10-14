module CamtParser
  class Creditor

    attr_reader :xml_data

    def initialize(xml_data)
      @xml_data = xml_data
    end

    def name
      @name ||= [
        xml_data.xpath('RltdPties/Cdtr/Nm/text()').text,
        xml_data.xpath('RltdPties/Cdtr/Pty/Nm/text()').text,
      ].reject(&:empty?).first.to_s
    end

    def iban
      @iban ||= xml_data.xpath('RltdPties/CdtrAcct/Id/IBAN/text()').text
    end

    def bic
      @bic ||= [
        xml_data.xpath('RltdAgts/CdtrAgt/FinInstnId/BIC/text()').text,
        xml_data.xpath('RltdAgts/CdtrAgt/FinInstnId/BICFI/text()').text,
      ].reject(&:empty?).first.to_s
    end

    def bank_name
      @bank_name ||= xml_data.xpath('RltdAgts/CdtrAgt/FinInstnId/Nm/text()').text
    end

    # @return [CamtParser::PostalAddress, nil]
    def postal_address # May be missing
      postal_address = [
        xml_data.xpath('RltdPties/Cdtr/PstlAdr'),
        xml_data.xpath('RltdPties/Cdtr/Pty/PstlAdr'),
      ].reject(&:empty?).first

      return nil if postal_address == nil || postal_address.empty?

      @address ||= CamtParser::PostalAddress.new(postal_address)
    end
  end
end
