module CamtParser
  class String
    def self.parse(raw_camt)
      doc = Nokogiri::XML raw_camt
      CamtParser::Xml.parse(doc)
    end
  end
end
