# frozen_string_literal: true

module CXML
  class InvoiceDetailSummary < DocumentNode
    accessible_nodes %i[
      subtotal_amount
      tax
      special_handling_amount
      shipping_amount
      gross_amount
      invoice_detail_discount
      net_amount
      deposit_amount
      due_amount
      total_allowances
      total_amount_without_tax
      total_charges
    ]
  end
end
