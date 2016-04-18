module CamtParser
  class Misc
    class << self
      def to_amount_in_cents(value)
        value.gsub(/[,|\.](\d*)/) { $1.ljust(2, '0') }.to_i
      end

      def to_amount(value)
        value.gsub(',','.').to_f
      end
    end
  end
end
