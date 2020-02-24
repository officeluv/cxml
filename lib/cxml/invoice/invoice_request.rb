module CXML
  module Invoice
    class InvoiceRequest
      private_class_method :new

      def initialize(xml, data)
        @data = new(data)
      end

      def self.compose(xml, data)
        xml.Request('deploymentMode': 'production') {
          xml.InvoiceDetailRequest {
            xml.InvoiceDetailRequestHeader('invoiceDate': "#{Date.new}", 'invoiceID': "#{Digest::SHA2.hexdigest("id")}", 'operation': "new", 'purpose': "standard") {
              xml.InvoiceDetailHeaderIndicator
              xml.InvoiceDetailLineIndicator('isAccountingInLine': 'yes')
              xml.PaymentTerm('payInNumberOfDays': '30')
            }
          }
        }
      end
    end
  end
end 