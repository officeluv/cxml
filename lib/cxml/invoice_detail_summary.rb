# frozen_string_literal: true

module CXML
  class InvoiceDetailSummary < DocumentNode
    accessible_nodes %i[
      subtotal_amount
      tax
      special_handling_amount
      gross_amount
      invoice_detail_discount
      total_charges
      total_allowances
      total_amount_without_tax
      net_amount
    ]
  end
end
