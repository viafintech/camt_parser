module CamtParser
  module Errors
    class NamespaceAlreadyRegistered < StandardError; end
    class NotXMLError < StandardError; end
    class UnsupportedParserClass < StandardError; end
    class UnsupportedNamespaceError < StandardError; end
  end
end
