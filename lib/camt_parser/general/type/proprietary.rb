module CamtParser
  module Type
    class Proprietary
      attr_reader :id, :issuer

      def initialize(id, issuer)
        @id, @issuer = id, issuer
      end
    end
  end
end
