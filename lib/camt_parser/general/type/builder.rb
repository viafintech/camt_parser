module CamtParser
  module Type
    class Builder
      def self.build_type(xml_data)
        if xml_data.xpath('Prtry').any?
          Proprietary.new(
            xml_data.xpath('Prtry/Id/text()').text,
            xml_data.xpath('Prtry/Issr/text()').text
          )
        elsif xml_data.xpath('Cd').any?
          Code.new(xml_data.xpath('Cd/text()').text)
        else
          nil
        end
      end
    end
  end
end
