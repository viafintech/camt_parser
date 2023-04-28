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

    # @return [String]
    def currency
      @currency ||= @xml_data.xpath('Amt/@Ccy').text
    end

    # @return [Boolean]
    def debit
      @debit ||= @xml_data.xpath('CdtDbtInd/text()').text.upcase == 'DBIT'
    end

    # @return [Date]
    def value_date
      @value_date ||= Date.parse(@xml_data.xpath('ValDt/Dt/text()').text)
    end

    # @return [Date]
    def booking_date
      @booking_date ||= Date.parse(@xml_data.xpath('BookgDt/Dt/text()').text)
    end

    # @return [String]
    def bank_reference # May be missing
      @bank_reference ||= @xml_data.xpath('AcctSvcrRef/text()').text
    end

    # @return [Array<CamtParser::Transaction>]
    def transactions
      @transactions ||= parse_transactions
    end

    # @return [Boolean]
    def credit?
      !debit
    end

    # @return [Boolean]
    def debit?
      debit
    end

    # @return [Integer] either 1 or -1
    def sign
      credit? ? 1 : -1
    end

    # @return [Boolean]
    def reversal?
      @reversal ||= @xml_data.xpath('RvslInd/text()').text.downcase == 'true'
    end

    # @return [Boolean]
    def booked?
      @booked ||= @xml_data.xpath('Sts/text()').text.upcase == 'BOOK'
    end

    # @return [String]
    def additional_information
      @additional_information ||= @xml_data.xpath('AddtlNtryInf/text()').text
    end
    alias_method :description, :additional_information

    # @return [CamtParser::Charges]
    def charges
      @charges ||= CamtParser::Charges.new(@xml_data.xpath('Chrgs'))
    end
    # @return [CamtParser::BatchDetail, nil]
    def batch_detail
      @batch_detail ||= @xml_data.xpath('NtryDtls/Btch').empty? ? nil : CamtParser::BatchDetail.new(@xml_data.xpath('NtryDtls/Btch'))
    end  

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
