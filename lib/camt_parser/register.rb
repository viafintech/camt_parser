require_relative './xml'

# Add registrations
## CAMT052
CamtParser::Xml.register('urn:iso:std:iso:20022:tech:xsd:camt.052.001.02', :camt052)

## CAMT053
CamtParser::Xml.register('urn:iso:std:iso:20022:tech:xsd:camt.053.001.02', :camt053)
CamtParser::Xml.register('urn:iso:std:iso:20022:tech:xsd:camt.053.001.04', :camt053)
CamtParser::Xml.register('urn:iso:std:iso:20022:tech:xsd:camt.053.001.08', :camt053)

## CAMT054
CamtParser::Xml.register('urn:iso:std:iso:20022:tech:xsd:camt.054.001.02', :camt054)
CamtParser::Xml.register('urn:iso:std:iso:20022:tech:xsd:camt.054.001.04', :camt054)
