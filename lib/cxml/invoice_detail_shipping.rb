# frozen_string_literal: true

module CXML
  class InvoiceDetailShipping < DocumentNode
    accessible_attributes %i[
      shipping_date
    ]
    accessible_nodes %i[
      contact
      document_reference
    ]
  end
end
