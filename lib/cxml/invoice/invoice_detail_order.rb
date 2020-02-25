module CXML
  module Invoice
    class InvoiceDetailOrder
      private_class_method :new

      USD_CURRENCY = 'USD'

      def initialize(xml, data)
        @data = new(data)
      end

      def self.compose(xml, data = [])
        data.each_with_index do |datum, i|
          xml.InvoiceDetailOrderInfo {
            xml.OrderReference {
              xml.DocumentReference('payloadID': "#{datum[:document_reference]}")
            }
            xml.InvoiceDetailItem('invoiceLineNumber': "#{i}", 'quantity': "#{datum[:quantity]}") {
              xml.UnitOfMeasure "#{datum[:unit_of_measure]}"
              xml.UnitPrice {
                xml.Money('currency': "#{USD_CURRENCY}") { xml.text("#{datum[:unit_price]}") }
              }
              xml.InvoiceDetailItemReference('lineNumber': "#{i}") {
                xml.Description('xml:lang': 'en') { xml.text("#{datum[:description]}") }
              }
              xml.SubtotalAmount {
                xml.Money('currency': USD_CURRENCY) { xml.text("#{datum[:subtotal_amount]}") }
              }
            }
          }
        end
        xml
      end
    end
  end
end 