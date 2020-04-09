# frozen_string_literal: true

module CXML
  class TaxAdjustmentAmount < DocumentNode
    accessible_nodes %i[
      money
    ]
  end
end
