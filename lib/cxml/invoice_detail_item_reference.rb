# frozen_string_literal: true

module CXML
  class InvoiceDetailItemReference < DocumentNode
    accessible_attributes %i[
      line_number
    ]
    accessible_nodes %i[
      description
      item_id
      classification
      manufacturer_part_id
      manufacturer_name
      country
    ]
  end
end
