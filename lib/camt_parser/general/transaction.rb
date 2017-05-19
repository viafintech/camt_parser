module CamtParser
  class Transaction
    def initialize(xml_data, debit, amount = nil, currency = nil)
      @xml_data = xml_data
      @debit    = debit
      @amount   = parse_amount || amount
      @currency = parse_currency || currency
    end

    def amount
      CamtParser::Misc.to_amount(@amount)
    end

    def amount_in_cents
      CamtParser::Misc.to_amount_in_cents(@amount)
    end

    def currency
      @currency
    end

    def creditor
      @creditor ||= CamtParser::Creditor.new(@xml_data)
    end

    def debitor
      @debitor ||= CamtParser::Debitor.new(@xml_data)
    end

    def name
      credit? ? debitor.name : creditor.name
    end

    def iban
      credit? ? debitor.iban : creditor.iban
    end

    def bic
      credit? ? debitor.bic : creditor.bic
    end

    def credit?
      !debit
    end

    def debit?
      debit
    end

    def debit
      @debit
    end

    def sign
      credit? ? 1 : -1
    end

    def remittance_information
      @remittance_information ||= begin
        if (x = @xml_data.xpath('RmtInf/Ustrd')).empty?
          nil
        else
          x.collect(&:content).join(' ')
        end
      end
    end

    def swift_code
      @swift_code ||= @xml_data.xpath('BkTxCd/Prtry/Cd/text()').text.split('+')[0]
    end

    def reference
      @reference ||= @xml_data.xpath('Refs/InstrId/text()').text
    end

    def bank_reference # May be missing
      @bank_reference ||= @xml_data.xpath('Refs/AcctSvcrRef/text()').text
    end

    def end_to_end_reference # May be missing
      @end_to_end_reference ||= @xml_data.xpath('Refs/EndToEndId/text()').text
    end

    def mandate_reference # May be missing
      @mandate_reference ||= @xml_data.xpath('Refs/MndtId/text()').text
    end

    def transaction_id # May be missing
      @transaction_id ||= @xml_data.xpath('Refs/TxId/text()').text
    end

    def creditor_identifier # May be missing
      @creditor_identifier ||= @xml_data.xpath('RltdPties/Cdtr/Id/PrvtId/Othr/Id/text()').text
    end

    def payment_information # May be missing
      @payment_information ||= @xml_data.xpath('Refs/PmtInfId/text()').text
    end

    private

    def parse_amount
      @amount = if @xml_data.xpath('Amt').any?
        @xml_data.xpath('Amt/text()').text
      elsif @xml_data.xpath('AmtDtls').any?
        @xml_data.xpath('AmtDtls/TxAmt/Amt/text()').text
      else
        nil
      end
    end

    def parse_currency
      @currenty = if @xml_data.xpath('Amt').any?
        @xml_data.xpath('Amt/@Ccy').text
      elsif @xml_data.xpath('AmtDtls').any?
        @xml_data.xpath('AmtDtls/TxAmt/Amt/@Ccy').text
      else
        nil
      end
    end
  end
end
