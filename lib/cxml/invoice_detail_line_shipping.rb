# frozen_string_literal: true

module CXML
  class InvoiceDetailLineShipping < DocumentNode
    accessible_nodes %i[
      invoice_detail_shipping
      money
      distribution
    ]
  end
end
