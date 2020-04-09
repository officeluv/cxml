# frozen_string_literal: true

module CXML
  class ConfirmationItem < DocumentNode
    accessible_attributes %i[
      quantity
      line_number
    ]
    accessible_nodes %i[
      confirmation_status
      unit_of_measure
    ]
  end
end
