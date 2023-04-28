module CamtParser
  class AccountBalance

    # @param amount [String]
    # @param currency [String]
    # @param date [String]
    # @param  credit [Boolean]
    def initialize(amount, currency, date, credit = false)
      @amount = amount
      @currency = currency
      @date = date
      @credit = credit
    end

    # @return [String]
    def currency
      @currency
    end

    # @return [Date]
    def date
      Date.parse @date
    end

    # @return [Integer] either 1 or -1
    def sign
      credit? ? 1 : -1
    end

    # @return [Boolean]
    def credit?
      @credit
    end

    # @return [BigDecimal]
    def amount
      CamtParser::Misc.to_amount(@amount)
    end

    # @return [Integer]
    def amount_in_cents
      CamtParser::Misc.to_amount_in_cents(@amount)
    end

    # @return [BigDecimal]
    def signed_amount
      amount * sign
    end

    # @return [Hash{String => BigDecimal, Integer}]
    def to_h
      {
        'amount' => amount,
        'amount_in_cents' => amount_in_cents,
        'sign' => sign
      }
    end
  end
end
