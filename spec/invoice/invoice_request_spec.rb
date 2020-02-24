require 'spec_helper'


describe CXML::Invoice::InvoiceRequest do
  let(:invoice) { Nokogiri::XML::Builder.new(:encoding => "UTF-8") }
  let(:doc) { CXML::Invoice::InvoiceRequest.compose(invoice, {}).to_xml.pretty_inspect }

  describe '#compose' do
    let(:keys) { ['Request', 'InvoiceDetailRequest', 
                  'InvoiceDetailRequestHeader', 'InvoiceDetailHeaderIndicator', 
                  'InvoiceDetailLineIndicator', 'PaymentTerm'] }

    it 'should return a document with specified keys' do
      keys.each do |key|
        expect(doc.include?("#{key}")).to be_true
      end
    end

  end
end 