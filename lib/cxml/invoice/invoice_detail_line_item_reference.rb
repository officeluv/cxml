# frozen_string_literal: true

module CXML
  module Invoice
    class InvoiceDetailLineItemReference
      private_class_method :new

      USD_CURRENCY = 'USD'

      def self.compose(xml, datum)
        datum[:invoice_detail_item][:invoice_detail_line_item_references].each do |lir|
          xml.InvoiceDetailItemReference('lineNumber': (lir[:line_number]).to_s) do
            xml.ItemId { xml.text((lir[:product_id]).to_s) }
            xml.SerialNumber { xml.text((lir[:gtin]).to_s) }
            xml.Description('xml:lang': 'en') { xml.text((lir[:description]).to_s) }
          end
        end
        xml
      end
    end
  end
end
