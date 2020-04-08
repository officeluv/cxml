# frozen_string_literal: true

module CXML
  # class for extrinsic data in punchout setup request
  class Extrinsic < DocumentNode
    accessible_attributes %i[
      name
    ]
  end
end
