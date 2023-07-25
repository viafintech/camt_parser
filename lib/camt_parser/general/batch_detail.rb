module CamtParser
  class BatchDetail

    attr_reader :xml_data

    def initialize(xml_data)
      @xml_data = xml_data
    end

    def payment_information_identification
      @payment_information_identification ||= xml_data.xpath('PmtInfId/text()').text
    end

    def msg_id # may be missing
      @msg_id ||= xml_data.xpath('MsgId/text()').text
    end

    def number_of_transactions
      @number_of_transactions ||= xml_data.xpath('NbOfTxs/text()').text
    end
  end  
end
