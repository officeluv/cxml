# frozen_string_literal: true

module CXML
  module Invoice
    class InvoiceDetailOrder
      private_class_method :new

      USD_CURRENCY = 'USD'

      def initialize(_xml, data)
        @data = new(data)
      end

      def self.compose(xml, data = [])
        data.each_with_index do |datum, i|
          xml.InvoiceDetailOrderInfo do
            xml.OrderReference do
              xml.DocumentReference('payloadID': (datum[:document_reference]).to_s)
            end
            xml.InvoiceDetailItem('invoiceLineNumber': i.to_s, 'quantity': (datum[:quantity]).to_s) do
              xml.UnitOfMeasure((datum[:unit_of_measure]).to_s)
              xml.UnitPrice do
                xml.Money('currency': USD_CURRENCY.to_s) { xml.text((datum[:unit_price]).to_s) }
              end
              xml.InvoiceDetailItemReference('lineNumber': i.to_s) do
                xml.Description('xml:lang': 'en') { xml.text((datum[:description]).to_s) }
              end
              xml.SubtotalAmount do
                xml.Money('currency': USD_CURRENCY) { xml.text((datum[:subtotal_amount]).to_s) }
              end
            end
          end
        end
        xml
      end
    end
  end
end
