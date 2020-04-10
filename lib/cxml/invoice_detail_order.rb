# frozen_string_literal: true

module CXML
  class InvoiceDetailOrder < DocumentNode
    accessible_nodes %i[
      invoice_detail_order_info
      invoice_detail_item
    ]
  end
end
