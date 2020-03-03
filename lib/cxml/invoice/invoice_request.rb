# frozen_string_literal: true

module CXML
  module Invoice
    class InvoiceRequest
      private_class_method :new

      def initialize(_xml, data)
        @data = new(data)
      end

      def self.compose(xml, data)
        xml.Request('deploymentMode': 'production') {
          xml.InvoiceDetailRequest {
            xml.InvoiceDetailRequestHeader('invoiceDate': data[:invoice_created_at], 'invoiceID': data[:invoice_id], 'operation': "new", 'purpose': "standard") {
              xml.InvoiceDetailHeaderIndicator
              xml.InvoiceDetailLineIndicator('isAccountingInLine': data[:is_accounting_line])
              xml.PaymentTerm('payInNumberOfDays': data[:terms])
            }
            CXML::Invoice::InvoiceDetailOrder.compose(xml, data[:invoice_detail_order][:data])
            CXML::Invoice::InvoiceDetailSummary.compose(xml, data[:invoice_detail_summary])
          }
        }
      end
    end
  end
end