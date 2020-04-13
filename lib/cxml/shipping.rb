# frozen_string_literal: true

module CXML
  class Shipping < DocumentNode
    accessible_nodes %i[
      money
      description
    ]
  end
end
