# frozen_string_literal: true

module CXML
  class ItemId < DocumentNode
    accessible_nodes %i[
      supplier_part_id
      supplier_part_auxiliary_id
    ]
  end
end
