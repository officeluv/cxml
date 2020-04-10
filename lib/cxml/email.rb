# frozen_string_literal: true

module CXML
  # address, typically in a purchase order message
  class Email < DocumentNode
    accessible_attributes %i[
      name
    ]
  end
end
