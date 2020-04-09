# frozen_string_literal: true

module CXML
  class TotalAmountWithoutTax < DocumentNode
    accessible_nodes %i[
      money
    ]
  end
end
