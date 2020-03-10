# frozen_string_literal: true

require 'spec_helper'

describe CXML::Invoice::InvoiceDetailSummary do
  let(:invoice) { Nokogiri::XML::Builder.new(encoding: 'UTF-8') }
  let(:data) { JSON.parse(fixture('example_input.json'), symbolize_names: true) }
  let(:doc) { CXML::Invoice::InvoiceDetailSummary.compose(invoice, data[:invoice_detail_summary]).to_xml.pretty_inspect }

  describe '#compose' do
    let(:keys) do
      %w[InvoiceDetailSummary SubtotalAmount Tax
         Description TaxDetail TaxableAmount TaxLocation
         SpecialHandlingAmount ShippingAmount NetAmount]
    end

    it 'should return a document with specified keys' do
      keys.each do |key|
        expect(doc.include?(key.to_s)).to eq(true)
      end
    end
  end
end
