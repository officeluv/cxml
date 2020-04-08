# frozen_string_literal: true

module CXML
  # postal address, typically in a purchase order message
  class PostalAddress < DocumentNode
    accessible_nodes %i[
      deliver_to
      state
      street
      city
      postal_code
      country
    ]
  end
end
