# frozen_string_literal: true

module CXML
  class Phone < DocumentNode
    accessible_attributes %i[
      name
    ]

    accessible_nodes %i[
      telephone_number
    ]
  end
end
