require 'spec_helper'

describe BzCamtParser::File do
  context "parse" do
    it "raises an exception if the namespace/format is unknown" do
      expect{
        described_class.parse 'spec/fixtures/invalid_namespace.xml'
      }.to raise_exception('unknown or unsupported namespace: ')
    end

    it "does not raise an exception for a valid namespace" do
      expect(BzCamtParser::Format053::Base).to receive(:new)
      described_class.parse 'spec/fixtures/valid_namespace.xml'
    end
  end
end
