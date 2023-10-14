require 'spec_helper'

RSpec.describe CamtParser::PostalAddress do
  let(:camt)           { CamtParser::File.parse('spec/fixtures/053/valid_example.xml') }
  let(:statements)     { camt.statements }
  let(:ex_stmt)        { statements[0] }
  let(:entries)        { ex_stmt.entries }
  let(:ex_entry)       { entries[0] }
  let(:transactions)   { ex_entry.transactions }
  let(:ex_transaction) { transactions[0] }
  let(:address)        { ex_transaction.postal_address }

  specify { expect(address.lines).to eq(["Berlin", "Infinite Loop 2", "12345"]) }
  specify { expect(address.xml_data).to_not be_nil }

  context "version 8" do
    let(:camt)     { CamtParser::File.parse('spec/fixtures/053/valid_example_v8.xml') }
    let(:ex_entry) { entries[2] }

    specify { expect(address.lines).to eq(["Hochstrasse 5", "4052 Basel"]) }
    specify { expect(address.country).to eq("CH") }
    specify { expect(address.street_name).to eq("") }
  end

  context "with structured address" do
    let(:camt)           { CamtParser::File.parse('spec/fixtures/053/valid_example_v4.xml') }
    let(:ex_entry)       { entries[6] }
    let(:ex_transaction) { transactions[1] }
    let(:entity)         { ex_transaction.debitor }
    let(:address)        { entity.postal_address }

    specify { expect(entity.name).to eq("Rutschmann Pia") }
    specify { expect(address.street_name).to eq("Marktgasse") }
    specify { expect(address.building_number).to eq("28") }
    specify { expect(address.postal_code).to eq("9400") }
    specify { expect(address.town_name).to eq("Rorschach") }
    specify { expect(address.country).to eq("CH") }
  end
end
