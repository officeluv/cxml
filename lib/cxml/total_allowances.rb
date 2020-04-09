# frozen_string_literal: true

module CXML
  class TotalAllowances < DocumentNode
    accessible_nodes %i[
      money
    ]
  end
end
