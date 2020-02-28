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
            xml_money(xml, data[:subtotal_amount])
          }
          xml.Tax {
            xml_money(xml, data[:tax])
            xml.Description('xml:lang': US_LANG) { xml.text(data[:tax_description]) }
            xml.TaxDetail('category': TAX, 'purpose': TAX, 'taxPointDate': "#{data[:tax_point_date]}") {

              xml.Category {
                xml.Category { xml.text(data[:tax_category]) }
              }
              xml.TaxableAmount {
                xml.Money('currency': USD_CURRENCY)
              }
              xml.TaxAmount {
                xml_money(xml, data[:tax_amount])
              }
              xml.TaxLocation('xml:lang': US_LANG) { xml.text( data[:tax_location] ) }
            }
          }
          
          xml.ShippingAmount {
            xml_money(xml, data[:shipping_amount])
          }

          xml.SpecialHandlingAmount {
            xml_money(xml, data[:special_handling])
          }

          xml.NetAmount {
            xml_money(xml, data[:net_amount])
          }

          xml.TotalCharges {
            xml_money(xml, data[:total_charges])
          }
        }
      end

      def self.xml_money(xml, amount)
        xml.Money('currency': USD_CURRENCY) { xml.text("#{amount}") }
      end
    end
  end
end 