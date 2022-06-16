require 'spec_helper'

RSpec.describe CamtParser::BatchDetail do
  let(:camt)       { CamtParser::File.parse('spec/fixtures/053/valid_example_with_batch.xml') }
  let(:statements)     { camt.statements }
  let(:ex_stmt)        { statements[0] }
  let(:entries)        { ex_stmt.entries }
  let(:ex_entry)       { entries[0] }
  let(:batch_detail)   { ex_entry.batch_detail }

  specify { expect(batch_detail.payment_information_identification).to eq("O0OpeAYTkhjerKu3eE9asw") }
  specify { expect(batch_detail.number_of_transactions).to eq("3") }
  specify { expect(batch_detail.msg_id).to eq('02453b1e17c11241073a777ad9c273b4149') }
end
