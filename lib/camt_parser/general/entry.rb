module CamtParser
  class Entry
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

    def debit
      @debit ||= @xml_data.xpath('CdtDbtInd/text()').text.upcase == 'DBIT'
    end

    def value_date
      @value_date ||= Date.parse(@xml_data.xpath('ValDt/Dt/text()').text)
    end

    def booking_date
      @booking_date ||= Date.parse(@xml_data.xpath('BookgDt/Dt/text()').text)
    end

    def transactions
      @transactions ||= parse_transactions
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

    def additional_information
      @additional_information ||= @xml_data.xpath('AddtlNtryInf/text()').text
    end
    alias_method :description, :additional_information

    private

    def parse_transactions
      transaction_details = @xml_data.xpath('NtryDtls/TxDtls')

      amt = nil
      ccy = nil

      if transaction_details.length == 1
        amt = @xml_data.xpath('Amt/text()').text
        ccy = @xml_data.xpath('Amt/@Ccy').text
      end

      @xml_data.xpath('NtryDtls/TxDtls').map { |x| Transaction.new(x, debit?, amt, ccy) }
    end
  end
end
