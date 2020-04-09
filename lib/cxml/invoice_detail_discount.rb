# frozen_string_literal: true

module CXML
  class InvoiceDetailDiscount < DocumentNode
    accessible_attributes %i[
      percentage_rate
    ]
    accessible_nodes %i[
      money
      distribution
    ]
  end
end
