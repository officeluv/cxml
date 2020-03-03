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
          xml.Description {
            xml.text(data[:description])
          }
          data[:tax_details].each do |tax_details|
            xml.Tax {
              xml_money(xml, tax_details[:tax])
              xml.Description('xml:lang': US_LANG) { xml.text(tax_details[:tax_description]) }
              xml.TaxDetail('category': TAX, 'purpose': TAX, 'taxPointDate': "#{tax_details[:tax_point_date]}") {
  
                xml.Category {
                  xml.Category { xml.text(tax_details[:tax_category]) }
                }
                xml.TaxableAmount {
                  xml.Money('currency': USD_CURRENCY)
                }
                xml.TaxAmount {
                  xml_money(xml, tax_details[:tax_amount])
                }
                xml.TaxLocation('xml:lang': US_LANG) { xml.text( tax_details[:tax_location] ) }
              }
            }
          end
          
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