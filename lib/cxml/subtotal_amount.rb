# frozen_string_literal: true

module CXML
  class SubtotalAmount < DocumentNode
    accessible_nodes %i[
      money
    ]
  end
end
