# frozen_string_literal: true

module CXML
  # shipping details object within punchout setup request
  class BillTo < DocumentNode
    accessible_nodes %i[
      address
    ]
  end
end
