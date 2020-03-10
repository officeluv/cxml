# frozen_string_literal: true

require 'spec_helper'

describe CXML::Invoice::InvoiceDetailOrder do
  let(:invoice) { Nokogiri::XML::Builder.new(encoding: 'UTF-8') }
  let(:data) { JSON.parse(fixture('example_input.json'), symbolize_names: true) }
  let(:doc) { CXML::Invoice::InvoiceDetailOrder.compose(invoice.root, data[:invoice_detail_order][:data]).pretty_inspect }

  describe '#compose' do
    let(:keys) do
      %w[InvoiceDetailOrderInfo OrderReference DocumentReference
         InvoiceDetailItem UnitOfMeasure UnitPrice Money
         InvoiceDetailItemReference Description SubtotalAmount]
    end

    it 'should return a document with specified keys' do
      keys.each do |key|
        expect(doc.include?(key.to_s)).to eq(true)
      end
    end
  end
end
