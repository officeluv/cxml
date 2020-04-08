# frozen_string_literal: true

module CXML
  # items in purchase order message
  class ItemOut < DocumentNode
    accessible_attributes %i[
      quantity
      line_number
    ]
    accessible_nodes %i[
      item_id
      item_detail
      distribution
      comments
    ]
  end
end
