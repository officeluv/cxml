# frozen_string_literal: true

module CXML
  class ItemDetail < DocumentNode
    accessible_nodes %i[
      description
      unit_of_measure
      unit_price
      classification
    ]
  end
end
