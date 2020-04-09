# frozen_string_literal: true

module CXML
  class InvoiceDetailHeaderIndicator < DocumentNode
    accessible_attributes %i[
      is_header_invoice
      is_vat_recoverable
      price_based_line_level_credit_memo
    ]
  end
end
