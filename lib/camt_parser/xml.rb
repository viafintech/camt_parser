module CamtParser
  class Xml
    def self.parse(doc)
      raise CamtParser::Errors::NotXMLError, doc.class unless doc.is_a? Nokogiri::XML::Document

      namespaces = doc.namespaces['xmlns']
      doc.remove_namespaces!

      case namespaces
      when 'urn:iso:std:iso:20022:tech:xsd:camt.052.001.02'
        return CamtParser::Format052::Base.new(doc.xpath('Document'))
      when 'urn:iso:std:iso:20022:tech:xsd:camt.053.001.02', 'urn:iso:std:iso:20022:tech:xsd:camt.053.001.04'
        return CamtParser::Format053::Base.new(doc.xpath('Document'))
      when 'urn:iso:std:iso:20022:tech:xsd:camt.054.001.04'
        return CamtParser::Format054::Base.new(doc.xpath('Document'))
      else
        raise CamtParser::Errors::UnsupportedNamespaceError, namespaces
      end
    end
  end
end