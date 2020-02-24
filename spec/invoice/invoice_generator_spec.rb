require 'spec_helper'


describe CXML::Invoice::InvoiceGenerator do
  let(:invoice) { "" }
  let(:doc) { CXML::Invoice::InvoiceGenerator.generate(invoice, true) }

  describe '#generate' do
    it 'should return an XML string' do
      expect(doc.include?('?xml')).to eq(true)
    end
  end
end 