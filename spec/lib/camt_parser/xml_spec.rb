require 'spec_helper'

describe CamtParser::Xml do
  def parse_xml(file)
    File.open file do |f|
      Nokogiri::XML.parse f
    end
  end

  context "parse" do
    it "raises an exception if it is not an XML" do
      expect{ 
        described_class.parse 'not_xml'
      }.to raise_exception(CamtParser::Errors::NotXMLError, String)
    end

    it "raises an exception if the namespace/format is unknown" do
      expect{ 
        described_class.parse parse_xml('spec/fixtures/general/invalid_namespace.xml')
      }.to raise_exception(CamtParser::Errors::UnsupportedNamespaceError, 'urn:iso:std:iso:20022:tech:xsd:camt.053.001.03')
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
