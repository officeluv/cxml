# frozen_string_literal: true

module CXML
  class DepositAmount < DocumentNode
    accessible_nodes %i[
      money
    ]
  end
end
