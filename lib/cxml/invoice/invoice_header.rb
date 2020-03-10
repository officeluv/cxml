# frozen_string_literal: true

module CXML
  module Invoice
    class InvoiceHeader
      private_class_method :new

      def initialize(_xml, data)
        @data = new(data)
      end

      def self.compose(xml, data)
        xml.Header do
          xml.From do
            xml.Credential('domain': 'COUPA') do
              xml.Identity data[:from]
            end
          end
          xml.To do
            xml.Credential('domain': 'COUPA') do
              xml.Identity data[:to]
            end
          end
          xml.Sender do
            xml.Credential('domain': 'COUPA') do
              xml.Identity data[:sender][:identity]
              xml.SharedSecret data[:sender][:shared_secret]
            end
            xml.UserAgent data[:user_agent]
          end
        end
      end
    end
  end
end
