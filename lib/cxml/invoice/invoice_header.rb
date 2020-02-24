module CXML
  module Invoice
    class InvoiceHeader
      private_class_method :new

      def initialize(xml, data)
        @data = new(data)
      end

      def self.compose(xml, data)
        xml.Header {
          xml.From {
            xml.Credential('domain': 'COUPA') {
              xml.Identity "SUPPLIER ID"
            }
          }
          xml.To {
            xml.Credential('domain': 'COUPA') {
              xml.Identity "BUYER ID"
            }
          }
          xml.Sender {
            xml.Credential('domain': 'COUPA') {
              xml.Identity {

              }
              xml.SharedSecret "123456secret"
            }
            xml.UserAgent "Coupa Integration V01"
          }
        }
      end
    end
  end
end 