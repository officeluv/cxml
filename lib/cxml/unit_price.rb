# frozen_string_literal: true

module CXML
  class UnitPrice < DocumentNode
    accessible_nodes %i[
      money
    ]
  end
end
