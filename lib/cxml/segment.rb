# frozen_string_literal: true

module CXML
  # details for accounting objects
  class Segment < DocumentNode
    accessible_attributes %i[
      id
      description
      type
    ]
  end
end
