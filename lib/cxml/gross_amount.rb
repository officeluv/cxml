# frozen_string_literal: true

module CXML
  class GrossAmount < DocumentNode
    accessible_nodes %i[
      money
    ]
  end
end
