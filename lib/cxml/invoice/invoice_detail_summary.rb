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
            xml_money(xml, data[:amount])
          }
          xml.Description {
            xml.text(data[:description])
          }
          data[:tax_details].each do |tax_details|
            xml.Tax {
              xml_money(xml, tax_details[:tax])
              xml.Description('xml:lang': US_LANG) { xml.text(tax_details[:description]) }
              xml.TaxDetail('category': TAX, 'purpose': TAX, 'rate': tax_details[:rate]) {
                xml.Category {
                  xml.Category { xml.text(tax_details[:description]) }
                }
                xml.TaxableAmount {
                  xml_money(xml, tax_details[:taxable_amount])
                }
                xml.TaxAmount {
                  xml_money(xml, tax_details[:tax_amount])
                }
                xml.TaxLocation('xml:lang': US_LANG) { 
                  xml.text( tax_details[:location] )
                }
              }
            }
          end
          
          xml.ShippingAmount {
            xml_money(xml, data[:shipping_amount])
          }

          xml.SpecialHandlingAmount {
            xml_money(xml, data[:special_handling_amount])
          }

          xml.NetAmount {
            xml_money(xml, data[:net_amount])
          }

          xml.TotalCharges {
            xml_money(xml, data[:net_amount])
          }
        }
      end

      def self.xml_money(xml, amount)
        xml.Money('currency': USD_CURRENCY) { xml.text("#{amount}") }
      end
    end
  end
end 