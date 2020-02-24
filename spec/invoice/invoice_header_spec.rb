require 'spec_helper'


describe CXML::Invoice::InvoiceHeader do
  let(:invoice) { Nokogiri::XML::Builder.new(:encoding => "UTF-8") }
  let(:doc) { CXML::Invoice::InvoiceHeader.compose(invoice, {}).to_xml.pretty_inspect }

  describe '#compose' do
    let(:keys) { ['Header', 'From', 'Credential', 
                  'Identity', 'To', 'Sender', 'SharedSecret', 
                  'UserAgent'] }

    it 'should return a document with specified keys' do
      keys.each do |key|
        expect(doc.include?("#{key}")).to be_true
      end
    end

  end
end 