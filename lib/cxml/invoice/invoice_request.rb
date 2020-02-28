# frozen_string_literal: true

module CXML
  module Invoice
    class InvoiceRequest
      private_class_method :new

      def initialize(_xml, data)
        @data = new(data)
      end

      def self.compose(xml, data)
        xml.Request('deploymentMode': 'production') do
          xml.InvoiceDetailRequest do
            # TODO: include isTaxInLine as true/option
            # TODO: include isAccountingInLine as false/option
            xml.InvoiceDetailRequestHeader(
              'invoiceDate': Date.new.to_s,
              'invoiceID': Digest::SHA2.hexdigest('id').to_s,
              'operation': 'new',
              'purpose': 'standard'
            ) do
              xml.InvoiceDetailHeaderIndicator
              xml.InvoiceDetailLineIndicator('isAccountingInLine': 'yes')
              xml.PaymentTerm('payInNumberOfDays': '30')
            end
            CXML::Invoice::InvoiceDetailOrder.compose(xml, data[:invoice_detail_order][:data])
            CXML::Invoice::InvoiceDetailSummary.compose(xml, data[:invoice_detail_summary])
          end
        end
      end
    end
  end
end
