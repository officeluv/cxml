# frozen_string_literal: true

module CXML
  class ModificationDetail < DocumentNode
    accessible_attributes %i[
      name
      start_date
      end_date
      code
    ]
    accessible_nodes %i[
      description
      extrinsic
    ]
  end
end
