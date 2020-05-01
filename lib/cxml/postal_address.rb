# frozen_string_literal: true

module CXML
  # postal address, typically in a purchase order message
  class PostalAddress < DocumentNode
    accessible_attributes %i[
      name
    ]
    accessible_nodes %i[
      deliver_to
      street
      municipality
      city
      state
      postal_code
      country
    ]

    def initialize_deliver_to(value)
      @deliver_to = if value.is_a?(Array)
                      value
                    else
                      [value]
                    end
    end

    def initialize_street(value)
      @street = if value.is_a?(Array)
                  value
                else
                  [value]
                end
    end
  end
end
