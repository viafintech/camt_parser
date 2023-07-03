require 'spec_helper'

RSpec.describe CamtParser::Account do
  let(:camt)       { CamtParser::File.parse('spec/fixtures/053/valid_example.xml') }
  let(:statements) { camt.statements }
  let(:ex_stmt)    { camt.statements[0] }
  let(:account) { ex_stmt.account }

  specify { expect(account.iban).to eq("DE14740618130000033626") }
  specify { expect(account.account_number).to eq("DE14740618130000033626") }
  specify { expect(account.bic).to eq("GENODEF1PFK") }
  specify { expect(account.bank_name).to eq("VR-Bank Rottal-Inn eG") }
  specify { expect(account.currency).to eq("EUR") }

  context 'with Other/Id as account_number' do
    let(:camt) { CamtParser::File.parse('spec/fixtures/053/valid_example_with_other_id.xml') }

    specify { expect(account.other_id).to eq("ABCDE1234") }
    specify { expect(account.account_number).to eq("ABCDE1234") }
  end

  context "version 8" do
    let(:camt) { CamtParser::File.parse('spec/fixtures/053/valid_example_v8.xml') }

    specify { expect(account.iban).to eq("CH1111111111111111111") }
    specify { expect(account.account_number).to eq("CH1111111111111111111") }
    specify { expect(account.bic).to eq("UBSWCHZH80A") }
    specify { expect(account.bank_name).to eq("UBS Switzerland AG") }
    specify { expect(account.currency).to eq("CHF") }
  end
end
