# frozen_string_literal: true

module CXML
  class TotalCharges < DocumentNode
    accessible_nodes %i[
      money
    ]
  end
end
