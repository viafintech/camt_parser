module CamtParser
  class Misc
    class << self
      def to_amount_in_cents(value)
        return nil if value == nil || value.strip == ''

        value.gsub(/[,|\.](\d*)/) { $1.ljust(2, '0') }.to_i
      end

      def to_amount(value)
        return nil if value == nil || value.strip == ''

        BigDecimal(value.gsub(',', '.'))
      end
    end
  end
end
