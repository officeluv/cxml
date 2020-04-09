# frozen_string_literal: true

module CXML
  class NetAmount < DocumentNode
    accessible_nodes %i[
      money
    ]
  end
end
