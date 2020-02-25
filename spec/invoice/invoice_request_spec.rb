require 'spec_helper'


describe CXML::Invoice::InvoiceRequest do
  let(:invoice) { Nokogiri::XML::Builder.new(:encoding => "UTF-8") }
  let(:data) { JSON.parse(fixture('example_input.json'), symbolize_names: true) }
  let(:doc) { CXML::Invoice::InvoiceRequest.compose(invoice.root, data).pretty_inspect }

  describe '#compose' do
    let(:keys) { ['Request', 'InvoiceDetailRequest', 
                  'InvoiceDetailRequestHeader', 'InvoiceDetailHeaderIndicator', 
                  'InvoiceDetailLineIndicator', 'PaymentTerm'] }

    it 'should return a document with specified keys' do
      keys.each do |key|
        expect(doc.include?("#{key}")).to eq(true)
      end
    end

  end
end 