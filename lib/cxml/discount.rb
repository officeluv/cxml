# frozen_string_literal: true

module CXML
  class Discount < DocumentNode
    accessible_nodes %i[
      discount_percent
      discount_due_days
    ]
  end
end
