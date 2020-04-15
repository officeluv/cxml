# frozen_string_literal: true

module CXML
  class AdditionalDeduction < DocumentNode
    accessible_nodes %i[
      money
      deduction_amount
      deduction_percent
      deducted_price
    ]
  end
end
