# frozen_string_literal: true

module CXML
  class InvoiceDetailRequest < DocumentNode
    accessible_nodes %i[
      invoice_detail_request_header
      invoice_detail_header_orders
      invoice_detail_orders
      invoice_detail_summary
    ]

    def initialize_invoice_detail_orders(value)
      value = [value] unless value.is_a?(Array)
      @invoice_detail_orders = value.map do |item|
        InvoiceDetailOrder.new(item)
      end
    end

    def initialize_invoice_detail_order(value)
      value = [value] unless value.is_a?(Array)
      @invoice_detail_orders = value.map do |item|
        InvoiceDetailOrder.new(item)
      end
    end

    def initialize_invoice_detail_header_orders(value)
      value = [value] unless value.is_a?(Array)
      @invoice_detail_header_orders = value.map do |item|
        InvoiceDetailHeaderOrder.new(item)
      end
    end

    def initialize_invoice_detail_header_order(value)
      value = [value] unless value.is_a?(Array)
      @invoice_detail_header_orders = value.map do |item|
        InvoiceDetailHeaderOrder.new(item)
      end
    end
  end
end
