require 'spec_helper'

RSpec.describe CamtParser::Format053::Statement do
  context 'version 2' do
    let(:camt)       { CamtParser::File.parse('spec/fixtures/053/valid_example.xml') }
    let(:statements) { camt.statements }
    let(:ex_stmt)    { camt.statements[0] }

    specify { expect(statements).to all(be_kind_of(described_class)) }
    specify { expect(ex_stmt.identification).to eq("0352C5320131227220503") }
    specify { expect(ex_stmt.generation_date).to be_kind_of(Time) }
    specify { expect(ex_stmt.from_date_time).to be_nil }
    specify { expect(ex_stmt.to_date_time).to be_nil }
    specify { expect(ex_stmt.account).to be_kind_of(CamtParser::Account) }
    specify { expect(ex_stmt.entries).to be_kind_of(Array) }
    specify { expect(ex_stmt.electronic_sequence_number).to eq('130000005') }

    specify { expect(ex_stmt.opening_balance).to be_kind_of(CamtParser::AccountBalance) }
    specify { expect(ex_stmt.closing_balance).to be_kind_of(CamtParser::AccountBalance) }

    specify { expect(ex_stmt.identification).to eq("0352C5320131227220503") }

    specify { expect(ex_stmt.xml_data).to_not be_nil }
  end

  context 'version 4' do
    let(:camt)          { CamtParser::File.parse('spec/fixtures/053/valid_example_v4.xml') }
    let(:statements)    { camt.statements }
    let(:ex_stmt)       { camt.statements[0] }
    let(:ex_ntry)       { ex_stmt.entries[0] }
    let(:ex_ntry_chrgs) { ex_stmt.entries[0] }

    specify { expect(ex_ntry.charges).to be_kind_of(CamtParser::Charges)}

    specify { expect(ex_stmt.xml_data).to_not be_nil }
  end

  context 'version 8' do
    let(:camt)          { CamtParser::File.parse('spec/fixtures/053/valid_example_v8.xml') }

    let(:statements)    { camt.statements }
    let(:ex_stmt)       { camt.statements[0] }
    let(:ex_ntry)       { ex_stmt.entries[0] }
    let(:ex_ntry_chrgs) { ex_stmt.entries[0] }

    specify { expect(ex_ntry.charges).to be_kind_of(CamtParser::Charges) }
    specify { expect(ex_stmt.identification).to eq("R30B4SA880HMZ9XA") }
    specify { expect(ex_stmt.generation_date).to be_kind_of(Time) }
    specify { expect(ex_stmt.from_date_time).to eq(Time.parse("2023-06-20 00:00:00 +0200")) }
    specify { expect(ex_stmt.to_date_time).to eq(Time.parse("2023-06-20 23:59:59 +0200")) }
    specify { expect(ex_stmt.account).to be_kind_of(CamtParser::Account) }
    specify { expect(ex_stmt.entries).to be_kind_of(Array) }
    specify { expect(ex_stmt.electronic_sequence_number).to eq("122") }

    specify { expect(ex_stmt.opening_balance).to be_kind_of(CamtParser::AccountBalance) }
    specify { expect(ex_stmt.closing_balance).to be_kind_of(CamtParser::AccountBalance) }

    specify { expect(ex_stmt.xml_data).to_not be_nil }
  end
end
