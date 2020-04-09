# frozen_string_literal: true

module CXML
  class ShippingAmount < DocumentNode
    accessible_nodes %i[
      money
      distribution
    ]
  end
end
