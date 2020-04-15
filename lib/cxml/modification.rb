# frozen_string_literal: true

module CXML
  class Modification < DocumentNode
    accessible_attributes %i[
      level
    ]
    accessible_nodes %i[
      original_price
      additional_cost
      additional_deduction
      modification_detail
    ]
  end
end
