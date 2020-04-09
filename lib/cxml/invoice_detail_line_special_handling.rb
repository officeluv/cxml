# frozen_string_literal: true

module CXML
  class InvoiceDetailLineSpecialHandling < DocumentNode
    accessible_nodes %i[
      description
      money
      distribution
    ]
  end
end
