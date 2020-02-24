require 'spec_helper'


describe CXML::Invoice::InvoiceDistribution do
  let(:invoice) { Nokogiri::XML::Builder.new(:encoding => "UTF-8") }
  let(:doc) { CXML::Invoice::InvoiceDistribution.compose(invoice, [1]).pretty_inspect }

  describe '#compose' do
    let(:keys) { ['Distribution', 'Accounting', 'AccountSegment', 
                  'Name', 'Description', 'Charge'] }

    it 'should return a document with specified keys' do
      keys.each do |key|
        expect(doc.include?("#{key}")).to be_true
      end
    end

  end
end