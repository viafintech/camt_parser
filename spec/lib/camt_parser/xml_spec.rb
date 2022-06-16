require 'spec_helper'

require 'securerandom'

RSpec.describe CamtParser::Xml do
  def parse_xml(file)
    File.open file do |f|
      Nokogiri::XML.parse f
    end
  end

  describe '.register' do
    let(:namespace) { SecureRandom.uuid } # get a unique namespace per test

    context 'when parser is not supported' do
      it 'raises CamtParser::Errors::NamespaceAlreadyRegistered' do
        expect {
          CamtParser::Xml.register(namespace, :unknown)
        }.to raise_exception(
          CamtParser::Errors::UnsupportedParserClass,
          'unknown'
        )
      end
    end

    CamtParser::Xml::PARSER_MAPPING.each do |parser_key, parser_class|
      context "when the parser is #{parser_key}" do
        context 'when the namespace is already registered' do
          it 'raises CamtParser::Errors::NamespaceAlreadyRegistered' do
            # should be ok
            CamtParser::Xml.register(namespace, parser_key)
            # raises an error
            expect {
              CamtParser::Xml.register(namespace, parser_key)
            }.to raise_exception(
              CamtParser::Errors::NamespaceAlreadyRegistered,
              namespace
            )
          end
        end

        context 'when the namespace is not registered' do
          it 'registers a parser for a namespace' do
            CamtParser::Xml.register(namespace, parser_key)

            expect(CamtParser::Xml.instance_variable_get(:'@namespace_parsers')[namespace])
              .to eq(parser_class)
          end
        end
      end
    end
  end

  describe '.parse' do
    it "raises an exception if it is not an XML" do
      expect {
        described_class.parse 'not_xml'
      }.to raise_exception(CamtParser::Errors::NotXMLError, String)
    end

    it "raises an exception if the namespace/format is unknown" do
      expect {
        described_class.parse parse_xml('spec/fixtures/general/invalid_namespace.xml')
      }.to raise_exception(
        CamtParser::Errors::UnsupportedNamespaceError,
        'urn:iso:std:iso:20022:tech:xsd:camt.053.001.03'
      )
    end

    it "does not raise an exception for a valid namespace" do
      expect(CamtParser::Format052::Base).to receive(:new)
      described_class.parse parse_xml('spec/fixtures/052/valid_namespace.xml')
    end

    it "does not raise an exception for a valid namespace" do
      expect(CamtParser::Format053::Base).to receive(:new)
      described_class.parse parse_xml('spec/fixtures/053/valid_namespace.xml')
    end
  end
end
