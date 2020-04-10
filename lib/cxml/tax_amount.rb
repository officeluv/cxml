# frozen_string_literal: true

module CXML
  class TaxAmount < DocumentNode
    accessible_nodes %i[
      money
    ]
  end
end
