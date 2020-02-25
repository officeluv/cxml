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
              xml.Identity data[:from]
            }
          }
          xml.To {
            xml.Credential('domain': 'COUPA') {
              xml.Identity data[:to]
            }
          }
          xml.Sender {
            xml.Credential('domain': 'COUPA') {
              xml.Identity data[:sender][:identity]
              xml.SharedSecret data[:sender][:shared_secret]
            }
            xml.UserAgent data[:user_agent]
          }
        }
      end
    end
  end
end 