# frozen_string_literal: true

module CXML
  class InvoiceDetailHeaderOrder < DocumentNode
    accessible_nodes %i[
      invoice_detail_order_info
      invoice_detail_order_summaries
    ]

    def initialize_invoice_detail_order_summary(value)
      value = [value] unless value.is_a?(Array)
      @invoice_detail_order_summaries = value.map do |item|
        InvoiceDetailOrderSummary.new(item)
      end
    end

    def initialize_invoice_detail_order_summaries(value)
      value = [value] unless value.is_a?(Array)
      @invoice_detail_order_summaries = value.map do |item|
        InvoiceDetailOrderSummary.new(item)
      end
    end
  end
end
