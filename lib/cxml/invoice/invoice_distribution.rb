module CXML
  module Invoice
    class InvoiceDistribution
      private_class_method :new

      USD_CURRENCY = 'USD'

      def initialize(xml, data)
        @data = new(data)
      end


      def self.compose(xml, data = [])
        data.each_with_index do |i, datum|
          xml.Distribution {
            xml.Accounting('name': "Buyer assigned accounting code 1") {
              xml.AccountSegment('id': "#{rand(100)}") {
                xml.Name('xml:lang': 'en') { xml.text("Purchase") }
                xml.Description('xml:lang': 'en') { xml.text("Production Control") }
              }
            }
            xml.Charge {
              xml.Money('currency': "#{USD_CURRENCY}")
            }
          }
        end
        xml
      end
    end
  end
end 