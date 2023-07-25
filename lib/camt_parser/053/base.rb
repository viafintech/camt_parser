module CamtParser
  module Format053
    class Base
      attr_reader :group_header, :statements, :xml_data

      def initialize(xml_data)
        @xml_data = xml_data

        grphdr = xml_data.xpath('BkToCstmrStmt/GrpHdr')
        @group_header = GroupHeader.new(grphdr)
        statements = xml_data.xpath('BkToCstmrStmt/Stmt')
        @statements = statements.map{ |x| Statement.new(x) }
      end
    end
  end
end
