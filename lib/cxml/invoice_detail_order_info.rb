# frozen_string_literal: true

module CXML
  class InvoiceDetailOrderInfo < DocumentNode
    accessible_nodes %i[
      order_reference
    ]
  end
end
