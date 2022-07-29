module CamtParser
  class Account
    def initialize(xml_data)
      @xml_data = xml_data
    end

    def iban
      @iban ||= @xml_data.xpath('Id/IBAN/text()').text
    end

    def other_id
      @other_id ||= @xml_data.xpath('Id/Othr/Id/text()').text
    end

    def account_number
      !iban.nil? && !iban.empty? ? iban : other_id
    end

    def bic
      @bic ||= @xml_data.xpath('Svcr/FinInstnId/BIC/text()').text
    end

    def bank_name
      @bank_name ||= @xml_data.xpath('Svcr/FinInstnId/Nm/text()').text
    end

    def currency
      @currency ||= @xml_data.xpath('Ccy/text()').text
    end
  end
end
