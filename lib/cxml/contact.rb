# frozen_string_literal: true

module CXML
  # contact object within punchout setup request
  class Contact < DocumentNode
    accessible_attributes %i[
      role
      address_id
    ]
    accessible_nodes %i[
      name
      postal_address
      email
      phone
      fax
      url
    ]
  end
end
