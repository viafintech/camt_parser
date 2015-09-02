require 'time'
require 'bigdecimal'

module BzCamtParser
  module Format053
    class Statement
      attr_reader :identification, :creation_date_time, :from_date_time, :to_date_time,
                  :account, :entries

      def initialize(xml_data)
        @identification             = (x = xml_data.xpath('Id')).empty? ? nil : x.first.content
        @creation_date_time         = Time.parse(xml_data.xpath('CreDtTm').first.content)
        @from_date_time             = (x = xml_data.xpath('FrToDt/FrDtTm')).empty? ? nil : Time.parse(x.first.content)
        @to_date_time               = (x = xml_data.xpath('FrToDt/ToDtTm')).empty? ? nil : Time.parse(x.first.content)
        @account                    = Account.new(xml_data.xpath('Acct').first)
        @entries                    = xml_data.xpath('Ntry').map{ |x| Entry.new(x) }
      end
    end

    class Entry
      attr_reader :amount, :currency, :value_date, :debitor, :creditor, :remittance_information

      def initialize(xml_data)
        @amount     = BigDecimal.new(xml_data.xpath('Amt').first.content)
        @currency   = xml_data.xpath('Amt/@Ccy').first.content
        @debit      = xml_data.xpath('CdtDbtInd').first.content.upcase == 'DBIT'
        @value_date = Date.parse(xml_data.xpath('ValDt/Dt').first.content)
        @creditor   = Creditor.new(xml_data.xpath('NtryDtls'))
        @debitor    = Debitor.new(xml_data.xpath('NtryDtls'))
        # Makes the assumption that only unstructured remittance information will be given
        if (x = xml_data.xpath('NtryDtls/TxDtls/RmtInf/Ustrd')).empty?
          @remittance_information = nil
        else
          @remittance_information = x.collect(&:content).join(' ')
        end
      end

      def debit?
        @debit
      end
    end

    class Account
      attr_reader :iban, :bic, :bank_name

      def initialize(xml_data)
        @iban           = (x = xml_data.xpath('Id/IBAN')).empty? ? nil : x.first.content
        @bic            = (x = xml_data.xpath('Svcr/FinInstnId/BIC')).empty? ? nil : x.first.content
        @bank_name      = (x = xml_data.xpath('Svcr/FinInstnId/Nm')).empty? ? nil : x.first.content
      end
    end

    class Debitor
      attr_reader :iban, :bic, :bank_name, :name

      def initialize(xml_data)
        @name       = (x = xml_data.xpath('TxDtls/RltdPties/Dbtr/Nm')).empty? ? nil : x.first.content
        @iban       = (x = xml_data.xpath('TxDtls/RltdPties/DbtrAcct/Id/IBAN')).empty? ? nil : x.first.content
        @bic        = (x = xml_data.xpath('TxDtls/RltdAgts/DbtrAgt/FinInstnId/BIC')).empty? ? nil : x.first.content
        @bank_name  = (x = xml_data.xpath('TxDtls/RltdAgts/DbtrAgt/FinInstnId/Nm')).empty? ? nil : x.first.content
      end
    end

    class Creditor
      attr_reader :iban, :bic, :bank_name, :name

      def initialize(xml_data)
        @name       = (x = xml_data.xpath('TxDtls/RltdPties/Cdtr/Nm')).empty? ? nil : x.first.content
        @iban       = (x = xml_data.xpath('TxDtls/RltdPties/CdtrAcct/Id/IBAN')).empty? ? nil : x.first.content
        @bic        = (x = xml_data.xpath('TxDtls/RltdAgts/CdtrAgt/FinInstnId/BIC')).empty? ? nil : x.first.content
        @bank_name  = (x = xml_data.xpath('TxDtls/RltdAgts/CdtrAgt/FinInstnId/Nm')).empty? ? nil : x.first.content
      end
    end
  end
end
