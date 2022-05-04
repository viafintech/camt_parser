module CamtParser
  class Misc
    class << self
      def to_amount_in_cents(value)
        return nil if value == nil || value.strip == ''

        dollars, cents = value.split(/,|\./)
        cents ||= '0'
        format('%s%s', dollars, cents.ljust(2, '0')).to_i
      end

      def to_amount(value)
        return nil if value == nil || value.strip == ''

        BigDecimal(value.gsub(',', '.'))
      end
    end
  end
end
