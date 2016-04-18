require 'spec_helper'

describe CamtParser::Format053::Statement do
  let(:camt)       { CamtParser::File.parse('spec/fixtures/valid_example.xml') }
  let(:statements) { camt.statements }
  let(:ex_stmt)    { camt.statements[0] }

  it "parses the statements properly into classes" do
    classes = statements.collect(&:class).uniq
    expect(classes.length).to eq(1)
    expect(classes.first).to eq(described_class)
  end

  it "contains certain attributes" do
    expect(ex_stmt.identification).to eq("0352C5320131227220503")
    expect(ex_stmt.generation_date.class).to eq(Time)
    expect(ex_stmt.from_date_time).to eq(nil)
    expect(ex_stmt.to_date_time).to eq(nil)
    expect(ex_stmt.account.class).to eq(CamtParser::Format053::Account)
    expect(ex_stmt.entries.class).to eq(Array)
  end

  describe CamtParser::Format053::Account do
    let(:account) { ex_stmt.account }

    it "parses the account properly into a class" do
      expect(account.iban).to eq("DE14740618130000033626")
      expect(account.bic).to eq("GENODEF1PFK")
      expect(account.bank_name).to eq("VR-Bank Rottal-Inn eG")
    end
  end

  describe CamtParser::Format053::Entry do
    let(:entries)  { ex_stmt.entries }
    let(:ex_entry) { ex_stmt.entries[0] }

    it "parses the entries properly into classes" do
      classes = entries.collect(&:class).uniq
      expect(classes.length).to eq(1)
      expect(classes.first).to eq(described_class)
    end

    it "contains certain attributes" do
      expect(ex_entry.amount.class).to eq(Float)
      expect(ex_entry.amount).to eq(BigDecimal.new('2'))
      expect(ex_entry.currency).to eq('EUR')
      expect(ex_entry.value_date.class).to eq(Date)
      expect(ex_entry.value_date).to eq(Date.new(2013, 12, 27))
      expect(ex_entry.creditor.class).to eq(CamtParser::Format053::Creditor)
      expect(ex_entry.debitor.class).to eq(CamtParser::Format053::Debitor)
      expect(ex_entry.remittance_information).to eq("TEST BERWEISUNG MITTELS BLZUND KONTONUMMER - DTA")
      expect(ex_entry.additional_information).to eq(
        "Überweisungs-Gutschrift; GVC: SEPA Credit Transfer (Einzelbuchung-Haben)"
      )
    end

    describe CamtParser::Format053::Debitor do
      let(:debitor) { ex_entry.debitor }

      it "contains certain attributes" do
        expect(debitor.name).to eq("Wayne Enterprises")
        expect(debitor.iban).to eq("DE24302201900609832118")
        expect(debitor.bic).to eq("DAAEDEDDXXX")
        expect(debitor.bank_name).to eq("")
      end
    end

    describe CamtParser::Format053::Creditor do
      let(:creditor) { ex_entry.creditor }

      it "contains certain attributes" do
        expect(creditor.name).to eq("Testkonto Nummer 2")
        expect(creditor.iban).to eq("DE09300606010012345671")
        expect(creditor.bic).to eq("DAAEDEDDXXX")
        expect(creditor.bank_name).to eq("Bank")
      end
    end
  end
end
