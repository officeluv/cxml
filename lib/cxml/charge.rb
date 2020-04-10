# frozen_string_literal: true

module CXML
  class Charge < DocumentNode
    accessible_nodes %i[
      money
    ]
  end
end
