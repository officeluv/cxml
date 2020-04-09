# frozen_string_literal: true

module CXML
  class InvoiceDetailOrderSummary < DocumentNode
    accessible_attributes %i[
      invoice_line_number
      inspection_date
    ]
    accessible_nodes %i[
      subtotal_amount
      period
      tax
      invoice_detail_line_special_handling
      invoice_detail_line_shipping
      gross_amount
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
