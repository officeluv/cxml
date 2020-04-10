# frozen_string_literal: true

module CXML
  class InvoiceIDInfo < DocumentNode
    accessible_attributes %i[
      invoice_id
      invoice_date
    ]
  end
end
