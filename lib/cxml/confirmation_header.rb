# frozen_string_literal: true

module CXML
  class ConfirmationHeader < DocumentNode
    accessible_attributes %i[
      confirm_id
      operation
      type
      notice_date
      invoice_id
    ]
    accessible_nodes %i[
      contact
    ]
  end
end
