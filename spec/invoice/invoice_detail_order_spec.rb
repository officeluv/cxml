require 'spec_helper'


describe CXML::Invoice::InvoiceDetailOrder do
  let(:invoice) { Nokogiri::XML::Builder.new(:encoding => "UTF-8") }
  let(:doc) { CXML::Invoice::InvoiceDetailOrder.compose(invoice, [1]).pretty_inspect }

  describe '#compose' do
    let(:keys) { ['InvoiceDetailOrderInfo', 'OrderReference', 'DocumentReference', 
                  'InvoiceDetailItem', 'UnitOfMeasure', 'UnitPrice', 'Money', 
                  'InvoiceDetailItemReference', 'Description', 'SubtotalAmount'] }

    it 'should return a document with specified keys' do
      keys.each do |key|
        expect(doc.include?("#{key}")).to be_true
      end
    end

  end
end 