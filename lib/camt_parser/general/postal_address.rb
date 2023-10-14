module CamtParser
  class PostalAddress

    attr_reader :xml_data

    def initialize(xml_data)
      @xml_data = xml_data
    end

    # @return [Array<String>]
    def lines # May be empty
      xml_data.xpath('AdrLine').map do |x|
        x.xpath('text()').text
      end
    end

    # @return [String]
    def street_name # May be missing
      xml_data.xpath('StrtNm/text()').text
    end

    # @return [String]
    def building_number # May be missing
      xml_data.xpath('BldgNb/text()').text
    end

    # @return [String]
    def postal_code # May be missing
      xml_data.xpath('PstCd/text()').text
    end

    # @return [String]
    def town_name # May be missing
      xml_data.xpath('TwnNm/text()').text
    end

    # @return [String]
    def country # May be missing
      xml_data.xpath('Ctry/text()').text
    end

  end
end
