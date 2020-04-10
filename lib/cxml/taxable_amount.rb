# frozen_string_literal: true

module CXML
  class TaxableAmount < DocumentNode
    accessible_nodes %i[
      money
    ]
  end
end
