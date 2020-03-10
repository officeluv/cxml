# frozen_string_literal: true

require 'spec_helper'

describe CXML::Invoice::InvoiceDistribution do
  let(:invoice) { Nokogiri::XML::Builder.new(encoding: 'UTF-8') }
  let(:data) { JSON.parse(fixture('example_input.json'), symbolize_names: true) }
  let(:doc) { CXML::Invoice::InvoiceDistribution.compose(invoice, {}).to_xml.pretty_inspect }

  describe '#compose' do
    let(:keys) do
      %w[Distribution Accounting AccountSegment
         Name Description Charge]
    end

    xit 'should return a document with specified keys' do
      keys.each do |key|
        expect(doc.include?(key.to_s)).to eq(true)
      end
    end
  end
end
