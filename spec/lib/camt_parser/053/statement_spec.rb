require 'spec_helper'

describe CamtParser::Format053::Statement do
  let(:camt)       { CamtParser::File.parse('spec/fixtures/valid_example.xml') }
  let(:statements) { camt.statements }
  let(:ex_stmt)    { camt.statements[0] }

  specify { expect(statements).to all(be_kind_of(described_class)) }
  specify { expect(ex_stmt.identification).to eq("0352C5320131227220503") }
  specify { expect(ex_stmt.generation_date).to be_kind_of(Time) }
  specify { expect(ex_stmt.from_date_time).to be_nil }
  specify { expect(ex_stmt.to_date_time).to be_nil }
  specify { expect(ex_stmt.account).to be_kind_of(CamtParser::Format053::Account) }
  specify { expect(ex_stmt.entries).to be_kind_of(Array) }
  specify { expect(ex_stmt.electronic_sequence_number).to eq('130000005') }

  specify { expect(ex_stmt.opening_balance).to be_kind_of(CamtParser::Format053::AccountBalance) }
  specify { expect(ex_stmt.closing_balance).to be_kind_of(CamtParser::Format053::AccountBalance) }
end
