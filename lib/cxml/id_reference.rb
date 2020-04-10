# frozen_string_literal: true

module CXML
  class IdReference < DocumentNode
    accessible_attributes %i[
      domain
      identifier
    ]
    accessible_nodes %i[
      description
    ]
  end
end
