module CamtParser
  module Errors
    class BaseError < StandardError; end

    class NamespaceAlreadyRegistered < BaseError; end
    class NotXMLError < BaseError; end
    class UnsupportedParserClass < BaseError; end
    class UnsupportedNamespaceError < BaseError; end
  end
end
