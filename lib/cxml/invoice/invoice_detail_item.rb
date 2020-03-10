# frozen_string_literal: true

module CXML
  module Invoice
    class InvoiceDetailItem
      private_class_method :new

      USD_CURRENCY = 'USD'

      def self.compose(xml, datum)
        xml.InvoiceDetailItem('invoiceLineNumber': (datum[:line_item_invoice]).to_s, 'quantity': (datum[:quantity]).to_s, 'isAdHoc': false) do
          xml.UnitOfMeasure (datum[:invoice_detail_item][:unit_of_measure]).to_s
          xml.UnitPrice do
            xml.Money('currency': USD_CURRENCY.to_s) { xml.text((datum[:invoice_detail_item][:unit_price]).to_s) }
          end
          xml.GrossAmount do
            xml.Money('currency': USD_CURRENCY.to_s) { xml.text((datum[:invoice_detail_item][:gross_amount]).to_s) }
          end
          xml.SubtotalAmount do
            xml.Money('currency': USD_CURRENCY) { xml.text((datum[:invoice_detail_item][:subtotal_amount]).to_s) }
          end
        end
        xml
      end
    end
  end
end
