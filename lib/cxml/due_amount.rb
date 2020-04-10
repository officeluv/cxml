# frozen_string_literal: true

module CXML
  class DueAmount < DocumentNode
    accessible_nodes %i[
      money
    ]
  end
end
