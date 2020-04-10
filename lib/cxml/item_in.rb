# frozen_string_literal: true

module CXML
  class ItemIn < DocumentNode
    accessible_attributes %i[
      quantity
      line_number
    ]
    accessible_nodes %i[
      item_id
      item_detail
    ]
  end
end
