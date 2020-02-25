require 'spec_helper'


describe CXML::Invoice::InvoiceHeader do
  let(:invoice) { Nokogiri::XML::Builder.new(:encoding => "UTF-8") }
  let(:data) { JSON.parse(fixture('example_input.json'), symbolize_names: true) }
  let(:doc) { CXML::Invoice::InvoiceHeader.compose(invoice, data[:header]).to_xml.pretty_inspect }

  describe '#compose' do
    keys = ['Header', 'From', 'Credential', 
                  'Identity', 'To', 'Sender', 'SharedSecret', 
                  'UserAgent']
    keys.each do |key|
      it "should return a document with the key, #{key}" do
        expect(doc.include?("#{key}")).to eq(true)
      end
    end

  end
end 