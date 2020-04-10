# frozen_string_literal: true

module CXML
  # accounting info for ItemOut
  class Distribution < DocumentNode
    accessible_nodes %i[
      accounting
      charge
    ]
  end
end
