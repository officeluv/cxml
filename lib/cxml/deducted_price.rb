# frozen_string_literal: true

module CXML
  class DeductedPrice < DocumentNode
    accessible_nodes %i[
      money
    ]
  end
end
