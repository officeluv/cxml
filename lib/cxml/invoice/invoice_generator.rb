module CXML
  module Invoice
    class InvoiceGenerator
      private_class_method :new
      attr_reader :invoice_data
      def initialize(invoice_data)
        @invoice_data = new(invoice_data)
      end

      def self.generate(invoice_data = {}, print = false)
        cxml_invoice = Nokogiri::XML::Builder.new(:encoding => "UTF-8") do |xml|
          xml.cXML {
            CXML::Invoice::InvoiceHeader.compose(xml, invoice_data[:header])
            CXML::Invoice::InvoiceRequest.compose(xml, invoice_data)
          }
        end
        print_file(cxml_invoice) if print #debugging purposes
        cxml_invoice.to_xml
      end

      def self.print_file(cxml_invoice)
        output = File.open( "outputfile.xml","w" )
        output << cxml_invoice.to_xml
        output.close
      end
    end
  end
end