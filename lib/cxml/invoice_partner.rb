# frozen_string_literal: true

module CXML
  class InvoicePartner < DocumentNode
    accessible_nodes %i[
      contact
      id_reference
    ]
  end
end
