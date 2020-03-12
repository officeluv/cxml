# frozen_string_literal: true

require 'spec_helper'

describe CXML::Invoice::InvoiceGenerator do
  let(:data) { JSON.parse(fixture('example_input.json'), symbolize_names: true) }
  let(:bad_data) { JSON.parse(fixture('unhappy_input.json'), symbolize_names: true) }

  describe '#generate' do
    it 'should return an XML string' do
      doc = CXML::Invoice::InvoiceGenerator.generate(data, true)
      expect(doc.include?('?xml')).to eq(true)
    end
    it 'should correctly parse the file passed in' do
      expect(CXML::Invoice::InvoiceGenerator.generate(data, true)).to include('?xml')
    end
  end


  describe "#generate" do
    it 'should return a XML string for bad data' do
      doc = CXML::Invoice::InvoiceGenerator.generate(bad_data, true)
      expect(doc.include?('?xml')).to eq(true)
    end
  end
end
