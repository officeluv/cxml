# frozen_string_literal: true

module CXML
  class InvoicePartner < DocumentNode
    accessible_nodes %i[
      contact
    ]
  end
end
