# frozen_string_literal: true

module CXML
  class SpecialHandlingAmount < DocumentNode
    accessible_nodes %i[
      money
      description
      distribution
    ]
  end
end
