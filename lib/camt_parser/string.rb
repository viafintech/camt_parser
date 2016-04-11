module CamtParser
  class String
    def self.parse(raw_camt)
      doc = Nokogiri::XML raw_camt

      case doc.namespaces['xmlns']
      when 'urn:iso:std:iso:20022:tech:xsd:camt.053.001.02'
        doc.remove_namespaces!
        return CamtParser::Format053::Base.new(doc.xpath('Document'))
      else
        raise CamtParser::Errors::UnsupportedNamespaceError, doc.namespaces['xmlns']
      end
    end
  end
end
