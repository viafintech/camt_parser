module BzCamtParser
  class File
    def self.parse(path)
      f = ::File.open(path)
      doc = Nokogiri::XML(f)
      f.close

      case doc.namespaces["xmlns"]
      when "urn:iso:std:iso:20022:tech:xsd:camt.053.001.02"
        doc.remove_namespaces!
        return BzCamtParser::Format053::Base.new(doc.xpath("Document"))
      else
        raise "unknown or unsupported namespace: #{doc.namespaces["xlmns"]}"
      end
    end
  end
end
