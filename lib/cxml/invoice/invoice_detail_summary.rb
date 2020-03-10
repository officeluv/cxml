# frozen_string_literal: true

module CXML
  module Invoice
    class InvoiceDetailSummary
      private_class_method :new

      USD_CURRENCY = 'USD'
      US_LANG = 'en'
      TAX = 'tax'

      def initialize(_xml, data)
        @data = new(data)
      end

      def self.compose(xml, data)
        xml.InvoiceDetailSummary do
          xml.SubtotalAmount do
            xml_money(xml, data[:amount])
          end
          xml.Description do
            xml.text(data[:description])
          end
          data[:tax_details].each do |tax_details|
            xml.Tax do
              xml_money(xml, tax_details[:tax])
              xml.Description('xml:lang': US_LANG) { xml.text(tax_details[:description]) }
              xml.TaxDetail('category': TAX, 'purpose': TAX, 'rate': tax_details[:rate]) do
                xml.Category do
                  xml.Category { xml.text(tax_details[:description]) }
                end
                xml.TaxableAmount do
                  xml_money(xml, tax_details[:taxable_amount])
                end
                xml.TaxAmount do
                  xml_money(xml, tax_details[:tax_amount])
                end
                xml.TaxLocation('xml:lang': US_LANG) do
                  xml.text(tax_details[:location])
                end
              end
            end
          end

          xml.ShippingAmount do
            xml_money(xml, data[:shipping_amount])
          end

          xml.SpecialHandlingAmount do
            xml_money(xml, data[:special_handling_amount])
          end

          xml.NetAmount do
            xml_money(xml, data[:net_amount])
          end

          xml.TotalCharges do
            xml_money(xml, data[:net_amount])
          end
        end
      end

      def self.xml_money(xml, amount)
        xml.Money('currency': USD_CURRENCY) { xml.text(amount.to_s) }
      end
    end
  end
end
