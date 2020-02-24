module CXML
  module Invoice
    class InvoiceDetailOrder
      private_class_method :new

      USD_CURRENCY = 'USD'

      def initialize(xml, data)
        @data = new(data)
      end

      def self.compose(xml, data = [])
        data.each_with_index do |i, datum| #TODO Plug in invoice_distribution class here
          xml.InvoiceDetailOrderInfo {
            xml.OrderReference {
              xml.DocumentReference('payloadID': "#{rand(1000)}")
            }
            xml.InvoiceDetailItem('invoiceLineNumber': "#{i}", 'quantity': "#{rand(5)}") {
              xml.UnitOfMeasure "EA"
              xml.UnitPrice {
                xml.Money('currency': "#{USD_CURRENCY}") { xml.text("#{rand(1000)}") }
              }
              xml.InvoiceDetailItemReference('lineNumber': "#{i}") {
                xml.Description('xml:lang': 'en') { xml.text("Item Description") }
              }
              xml.SubtotalAmount {
                xml.Money('currency': USD_CURRENCY) { xml.text("#{rand(100)}") }
              }
            }
          }
        end
        xml
      end

    end
  end
end 