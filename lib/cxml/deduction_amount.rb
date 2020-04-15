# frozen_string_literal: true

module CXML
  class DeductionAmount < DocumentNode
    accessible_nodes %i[
      money
    ]
  end
end
