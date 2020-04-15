# frozen_string_literal: true

module CXML
  class AdditionalCost < DocumentNode
    accessible_nodes %i[
      money
      percentage
    ]
  end
end
