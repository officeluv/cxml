# frozen_string_literal: true

module CXML
  class ItemIn < DocumentNode
    accessible_attributes %i[
      quantity
    ]
    accessible_nodes %i[
      item_id
      item_detail
    ]
  end
end
