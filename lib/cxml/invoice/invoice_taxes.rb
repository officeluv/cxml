module CXML
  module Invoice
    class InvoiceTaxes
      private_class_method :new

      USD_CURRENCY = 'USD'
      XML_LANG = 'en-US'

      def self.compose(xml, datum)
        datum[:invoice_detail_item][:taxes].each do |tax|
          xml.Tax {
            xml.Money('currency': "#{USD_CURRENCY}") { xml.text("#{tax[:amount]}") }
            xml.Description('xml:lang': "#{XML_LANG}") { xml.text("#{tax[:description]}") }
            xml.TaxDetail('category': "#{tax[:category]}", 'percentageRate': "#{tax[:percentage_rate]}")
            xml.TaxableAmount {
              xml.Money('currency': "#{USD_CURRENCY}") { xml.text("#{tax[:taxable_amount]}") }
            }
            xml.TaxAmount {
              xml.Money('currency': "#{USD_CURRENCY}") { xml.text("#{tax[:tax_amount]}") }
            }
            xml.TaxLocation('xml:lang': "#{XML_LANG}") { xml.text("#{tax[:location]}") }
          }
        end
        xml
      end
    end
  end
end