# frozen_string_literal: true

module CXML
  class OrderReference < DocumentNode
    accessible_attributes %i[
      order_id
    ]
    accessible_nodes %i[
      document_reference
    ]
  end
end
