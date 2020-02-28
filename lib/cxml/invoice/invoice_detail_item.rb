module CXML
  module Invoice
    class InvoiceDetailItem
      private_class_method :new


      USD_CURRENCY = 'USD'

      def self.compose(xml, datum)
        xml.InvoiceDetailItem('invoiceLineNumber': "#{datum[:line_item_invoice]}", 'quantity': "#{datum[:quantity]}", 'isAdHoc': false) {
          xml.UnitOfMeasure "#{datum[:invoice_detail_item][:unit_of_measure]}"
          xml.UnitPrice {
            xml.Money('currency': "#{USD_CURRENCY}") { xml.text("#{datum[:invoice_detail_item][:unit_price]}") }
          }
          xml.GrossAmount {
            xml.Money('currency': "#{USD_CURRENCY}") { xml.text("#{datum[:invoice_detail_item][:gross_amount]}") }
          }
          xml.SubtotalAmount {
            xml.Money('currency': USD_CURRENCY) { xml.text("#{datum[:invoice_detail_item][:subtotal_amount]}") }
          }
        }
        xml
      end
    end
  end
end