module CamtParser
  class Xml
    PARSER_MAPPING = {
      camt052: CamtParser::Format052::Base,
      camt053: CamtParser::Format053::Base,
      camt054: CamtParser::Format054::Base
    }.freeze

    SUPPORTED_PARSERS = PARSER_MAPPING.keys.freeze

    @namespace_parsers = {}

    def self.register(namespace, parser)
      if !SUPPORTED_PARSERS.include?(parser)
        raise CamtParser::Errors::UnsupportedParserClass, parser.to_s
      end

      if @namespace_parsers.key?(namespace) # Prevent overwriting existing registrations
        raise CamtParser::Errors::NamespaceAlreadyRegistered, namespace
      end

      @namespace_parsers[namespace] = PARSER_MAPPING[parser]
    end

    def self.parse(doc)
      raise CamtParser::Errors::NotXMLError, doc.class unless doc.is_a? Nokogiri::XML::Document

      namespace = doc.namespaces['xmlns']
      doc.remove_namespaces!

      parser_class = @namespace_parsers[namespace]
      if parser_class == nil
        raise CamtParser::Errors::UnsupportedNamespaceError, namespace
      end

      return parser_class.new(doc.xpath('Document'))
    end
  end
end
