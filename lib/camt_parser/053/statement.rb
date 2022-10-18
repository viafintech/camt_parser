module CamtParser
  module Format053
    class Statement
      def initialize(xml_data)
        @xml_data = xml_data
      end

      def identification
        @identification ||= @xml_data.xpath('Id/text()').text
      end

      def generation_date
        @generation_date ||= Time.parse(@xml_data.xpath('CreDtTm/text()').text)
      end

      def from_date_time
        @from_date_time ||= (x = @xml_data.xpath('FrToDt/FrDtTm')).empty? ? nil : Time.parse(x.first.content)
      end

      def to_date_time
        @to_date_time ||= (x = @xml_data.xpath('FrToDt/ToDtTm')).empty? ? nil : Time.parse(x.first.content)
      end

      def account
        @account ||= Account.new(@xml_data.xpath('Acct').first)
      end

      def entries
        @entries ||= @xml_data.xpath('Ntry').map{ |x| Entry.new(x) }
      end

      def legal_sequence_number
        @legal_sequence_number ||= @xml_data.xpath('LglSeqNb/text()').text
      end

      def electronic_sequence_number
        @electronic_sequence_number ||= @xml_data.xpath('ElctrncSeqNb/text()').text
      end

      def opening_balance
        @opening_balance ||= begin
          bal = @xml_data.xpath('Bal/Tp//Cd[contains(text(), "OPBD") or contains(text(), "PRCD")]').first.ancestors('Bal')
          date = bal.xpath('Dt/Dt/text()').text
          credit = bal.xpath('CdtDbtInd/text()').text == 'CRDT'
          currency = bal.xpath('Amt').attribute('Ccy').value
          AccountBalance.new bal.xpath('Amt/text()').text, currency, date, credit
        end
      end

      def closing_balance
        @closing_balance ||= begin
          bal = @xml_data.xpath('Bal/Tp//Cd[contains(text(), "CLBD")]').first.ancestors('Bal')
          date = bal.xpath('Dt/Dt/text()').text
          credit = bal.xpath('CdtDbtInd/text()').text == 'CRDT'
          currency = bal.xpath('Amt').attribute('Ccy').value
          AccountBalance.new bal.xpath('Amt/text()').text, currency, date, credit
        end
      end
      alias_method :closing_or_intermediary_balance, :closing_balance

      def source
        @xml_data.to_s
      end

      def self.parse(xml)
        self.new Nokogiri::XML(xml).xpath('Stmt')
      end
    end
  end
end
