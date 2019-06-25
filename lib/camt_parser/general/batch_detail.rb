module CamtParser
  class BatchDetail
    def initialize(xml_data)
      @xml_data = xml_data
    end

    def payment_information_identification
      @payment_information_identification ||= @xml_data.xpath('PmtInfId/text()').text
    end

    def number_of_transactions
      @number_of_transactions ||= @xml_data.xpath('NbOfTxs/text()').text
    end
  end  
end
