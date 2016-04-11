module CamtParser
  module Format053
    class AccountBalance

      def initialize(amount, currency, date)
        @amount = amount
        @currency = currency
        @date = date
      end

      def currency
        @currency
      end

      def date
        Date.parse @date
      end

      def amount
        to_amount(@amount)
      end

      def sign
        1
      end

      def amount_in_cents
        to_amount_in_cents(@amount)
      end

      def to_amount_in_cents(value)
        value.gsub(/[,|\.](\d*)/) { $1.ljust(2, '0') }.to_i
      end

      def to_amount(value)
        value.gsub(',','.').to_f
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
