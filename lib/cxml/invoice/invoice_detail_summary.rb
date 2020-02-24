module CXML
  module Invoice
    class InvoiceDetailSummary
      private_class_method :new

      USD_CURRENCY = 'USD'
      US_LANG = 'en'
      TAX = 'tax'

      def initialize(xml, data)
        @data = new(data)
      end


      def self.compose(xml, data)
        xml.InvoiceDetailSummary {
          xml.SubtotalAmount {
            xml_money(xml, rand(1000))
          }
          xml.Tax {
            xml_money(xml, rand(1000))
            xml.Description('xml:lang': US_LANG) { xml.text('Tax Information') }
            xml.TaxDetail('category': TAX, 'purpose': TAX, 'taxPointDate': "#{Date.today}") {
              xml.TaxableAmount {
                xml.Money('currency': USD_CURRENCY)
              }
              xml.TaxAmount {
                xml_money(xml, rand(1000))
              }
              xml.TaxLocation('xml:lang': US_LANG) { xml.text('CA') }
            }
          }
          xml.SpecialHandlingAmount {
            xml_money(xml, rand(1000))
          }
          xml.ShippingAmount {
            xml_money(xml, rand(1000))
          }
          xml.NetAmount {
            xml_money(xml, rand(1000))
          }
        }
      end

      def self.xml_money(xml, amount)
        xml.Money('currency': USD_CURRENCY) { xml.text("#{amount}") }
      end
    end
  end
end 