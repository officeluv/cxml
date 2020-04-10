# frozen_string_literal: true

module CXML
  class InvoiceDetailSummary < DocumentNode
    accessible_nodes %i[
      gross_amount
      invoice_detail_discount
      net_amount
      shipping_amount
      special_handling_amount
      subtotal_amount
      tax
      total_allowances
      total_amount_without_tax
      total_charges
    ]
  end
end
