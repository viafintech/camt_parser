module CamtParser
  class Record
    def initialize(xml_data)
      @xml_data = xml_data
      @amount = @xml_data.xpath('Amt/text()').text
    end

    def amount
      CamtParser::Misc.to_amount(@amount)
    end

    def amount_in_cents
      CamtParser::Misc.to_amount_in_cents(@amount)
    end

    def currency
      @currency ||= @xml_data.xpath('Amt/@Ccy').text
    end

    def type
      @type ||= CamtParser::Type::Builder.build_type(@xml_data.xpath('Tp'))
    end

    def charges_included?
      @charges_included ||= @xml_data.xpath('ChrgInclInd/text()').text.downcase == 'true'
    end

    def debit
      @debit ||= @xml_data.xpath('CdtDbtInd/text()').text.upcase == 'DBIT'
    end

    def credit?
      !debit
    end

    def debit?
      debit
    end

    def sign
      credit? ? 1 : -1
    end
  end
end
