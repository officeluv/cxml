# frozen_string_literal: true

module CXML
  class DocumentReference < DocumentNode
    accessible_attributes %i[
      payload_id
    ]
  end
end
