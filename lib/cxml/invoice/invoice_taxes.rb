# frozen_string_literal: true

module CXML
  module Invoice
    class InvoiceTaxes
      private_class_method :new

      USD_CURRENCY = 'USD'
      XML_LANG = 'en-US'

      def self.compose(xml, datum)
        datum[:invoice_detail_item][:taxes].each do |tax|
          xml.Tax do
            xml.Money('currency': USD_CURRENCY.to_s) { xml.text((tax[:amount]).to_s) }
            xml.Description('xml:lang': XML_LANG.to_s) { xml.text((tax[:description]).to_s) }
            xml.TaxDetail('category': (tax[:category]).to_s, 'percentageRate': (tax[:percentage_rate]).to_s)
            xml.TaxableAmount do
              xml.Money('currency': USD_CURRENCY.to_s) { xml.text((tax[:taxable_amount]).to_s) }
            end
            xml.TaxAmount do
              xml.Money('currency': USD_CURRENCY.to_s) { xml.text((tax[:tax_amount]).to_s) }
            end
            xml.TaxLocation('xml:lang': XML_LANG.to_s) { xml.text((tax[:location]).to_s) }
          end
        end
        xml
      end
    end
  end
end
