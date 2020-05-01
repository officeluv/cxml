# frozen_string_literal: true

module CXML
  # address, typically in a purchase order message
  class Address < DocumentNode
    accessible_attributes %i[
      address_id
      iso_country_code
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
