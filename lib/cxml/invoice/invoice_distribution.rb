# frozen_string_literal: true

module CXML
  module Invoice
    class InvoiceDistribution
      private_class_method :new

      USD_CURRENCY = 'USD'

      def initialize(_xml, data)
        @data = new(data)
      end

      def self.compose(xml, data = [])
        data.each_with_index do |_i, _datum|
          xml.Distribution do
            xml.Accounting('name': 'Buyer assigned accounting code 1') do
              xml.AccountSegment('id': rand(100).to_s) do
                xml.Name('xml:lang': 'en') { xml.text('Purchase') }
                xml.Description('xml:lang': 'en') { xml.text('Production Control') }
              end
            end
            xml.Charge do
              xml.Money('currency': USD_CURRENCY.to_s)
            end
          end
        end
        xml
      end
    end
  end
end
