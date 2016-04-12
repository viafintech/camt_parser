module CamtParser
  module Format053
    class AccountBalance

      def initialize(amount, currency, date, credit = false)
        @amount = amount
        @currency = currency
        @date = date
        @credit = credit
      end

      def currency
        @currency
      end

      def date
        Date.parse @date
      end

      def sign
        credit? ? 1 : -1
      end

      def credit?
        @credit
      end

      def amount
        CamtParser::Misc.to_amount(@amount)
      end

      def amount_in_cents
        CamtParser::Misc.to_amount_in_cents(@amount)
      end

      def to_h
        {
          'amount' => amount,
          'amount_in_cents' => amount_in_cents,
          'sign' => sign
        }
      end
    end
  end
end
