require 'spec_helper'


describe CXML::Invoice::InvoiceDetailSummary do
  let(:invoice) { Nokogiri::XML::Builder.new(:encoding => "UTF-8") }
  let(:doc) { CXML::Invoice::InvoiceDetailSummary.compose(invoice, {}).to_xml.pretty_inspect }

  describe '#compose' do
    let(:keys) { ['InvoiceDetailSummary', 'SubtotalAmount', 'Tax', 
                  'Description', 'TaxDetail', 'TaxableAmount', 'TaxLocation', 
                  'SpecialHandlingAmount', 'ShippingAmount', 'NetAmount'] }

    it 'should return a document with specified keys' do
      keys.each do |key|
        expect(doc.include?("#{key}")).to be_true
      end
    end

  end
end 