module CamtParser
  class Account

    attr_reader :xml_data

    def initialize(xml_data)
      @xml_data = xml_data
    end

    # @return [String]
    def iban
      @iban ||= xml_data.xpath('Id/IBAN/text()').text
    end

    # @return [String]
    def other_id
      @other_id ||= xml_data.xpath('Id/Othr/Id/text()').text
    end

    # @return [String]
    def account_number
      !iban.nil? && !iban.empty? ? iban : other_id
    end

    # @return [String]
    def bic
      @bic ||= [
        xml_data.xpath('Svcr/FinInstnId/BIC/text()').text,
        xml_data.xpath('Svcr/FinInstnId/BICFI/text()').text,
      ].reject(&:empty?).first.to_s
    end

    # @return [String]
    def bank_name
      @bank_name ||= xml_data.xpath('Svcr/FinInstnId/Nm/text()').text
    end

    # @return [String]
    def currency
      @currency ||= xml_data.xpath('Ccy/text()').text
    end
  end
end
