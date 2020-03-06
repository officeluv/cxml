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
          xml.InvoiceDetailOrderInfo {
            xml.OrderReference {
              xml.DocumentReference('payloadID': "#{datum[:document_reference]}")
            }
            CXML::Invoice::InvoiceDetailItem.compose(xml, datum)
            CXML::Invoice::InvoiceDetailLineItemReference.compose(xml, datum)
            CXML::Invoice::InvoiceTaxes.compose(xml, datum)
          }
        end
        xml
      end
    end
  end
end