# frozen_string_literal: true

module CXML
  class InvoiceDetailOrder < DocumentNode
    accessible_nodes %i[
      invoice_detail_order_info
      invoice_detail_items
    ]

    def initialize_invoice_detail_item(value)
      value = [value] unless value.is_a?(Array)
      @invoice_detail_items = value.map do |item|
        InvoiceDetailItem.new(item)
      end
    end

    def initialize_invoice_detail_items(value)
      value = [value] unless value.is_a?(Array)
      @invoice_detail_items = value.map do |item|
        InvoiceDetailItem.new(item)
      end
    end
  end
end
